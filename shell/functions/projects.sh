###############################################################################
# PROJECT MANAGEMENT & SCAFFOLDING
###############################################################################

# Generador inteligente de archivos .env para proyectos
function gen-env() {
    local type=$1
    local file=".env"
    local example=".env.example"

    if [[ -z "$type" ]]; then
        type=$(echo -e "mysql\npostgres\nsqlserver\nempty" | fzf --prompt="󰆼 Select .env template: " --height=40% --layout=reverse --border)
        [[ -z "$type" ]] && return 0
    fi

    if [[ -f "$file" ]]; then
        echo -en "\033[1;33m⚠️  The .env file already exists. Overwrite? (y/n): \033[0m"
        read -r res
        [[ "$res" != "y" ]] && return 0
    fi

    # Sanitize current folder name for DB_NAME
    # 1. Lowercase
    # 2. Replace hyphens with underscores (Professional DB standard)
    # 3. Remove any other weird characters
    local folder_name=$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]' | tr '-' '_')
    local db_name=$(echo "$folder_name" | sed 's/[^a-z0-9_]//g')
    local random_pass=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 12)

    case "$type" in
        mysql)
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_NAME=${db_name}_db
DB_PASS=${random_pass}
DB_PORT=3306
DB_TYPE=mysql
DB_USER=admin
EOF
            cat <<EOF > "docker-compose.yml"
version: '3.8'
services:
  db:
    image: mysql:latest
    container_name: ${folder_name//_/-}-mysql
    restart: always
    environment:
      MYSQL_DATABASE: \${DB_NAME}
      MYSQL_USER: \${DB_USER}
      MYSQL_PASSWORD: \${DB_PASS}
      MYSQL_ROOT_PASSWORD: \${DB_PASS}
    ports:
      - "\${DB_PORT}:3306"
    volumes:
      - mysql_data:/var/lib/mysql
volumes:
  mysql_data:
EOF
            ;;
        postgres)
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_NAME=${db_name}_db
DB_PASS=${random_pass}
DB_PORT=5432
DB_TYPE=postgres
DB_USER=admin
EOF
            cat <<EOF > "docker-compose.yml"
version: '3.8'
services:
  db:
    image: postgres:latest
    container_name: ${folder_name//_/-}-postgres
    restart: always
    environment:
      POSTGRES_DB: \${DB_NAME}
      POSTGRES_USER: \${DB_USER}
      POSTGRES_PASSWORD: \${DB_PASS}
    ports:
      - "\${DB_PORT}:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
volumes:
  postgres_data:
EOF
            ;;
        sqlserver)
            local sql_pass="P${random_pass}!"
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_TYPE=sqlserver
DB_PASS=${sql_pass}
DB_PORT=1433
EOF
            ;;
        empty)
            touch "$file"
            ;;
        *)
            echo -e "\033[1;31mError:\033[0m Template for '$type' not found."
            return 1
            ;;
    esac

    # --- Sync .env.example ---
    sync-env

    # --- Direnv Support ---
    if command -v direnv >/dev/null 2>&1; then
        if [[ ! -f ".envrc" ]]; then
            echo "dotenv" > .envrc
            direnv allow 2>/dev/null
            echo -e "\033[1;33m🚀 .envrc created and allowed for direnv.\033[0m"
        fi
    fi

    # --- Git Protection ---
    if [[ -d ".git" || -f ".gitignore" ]]; then
        if gi_add ".env" "Security"; then
            echo -e "\033[1;33m🛡️  Added .env to .gitignore for security.\033[0m"
        fi
        
        # Ensure .env.example is NOT ignored
        if grep -q "^\.env.example$" .gitignore 2>/dev/null; then
            echo -e "\033[1;33m🔓 Removing .env.example from .gitignore (it should be public)...\033[0m"
            sed -i '/^\.env\.example$/d' .gitignore
            # Clean empty comments left behind if any
            sed -i '/^#.*Security$/d' .gitignore 2>/dev/null
        fi
    fi

    echo -e "\033[1;32m✅ .env generated for $type successfully.\033[0m"
    [[ "$type" != "sqlserver" && "$type" != "empty" ]] && echo -e "\033[1;34m󰆼 DB Name:\033[0m ${db_name}_db"
    [[ "$type" != "empty" ]] && echo -e "\033[1;34m🔑 Password:\033[0m $([[ "$type" == "sqlserver" ]] && echo "$sql_pass" || echo "$random_pass")"
}

# Sincroniza las llaves de .env a .env.example (sin valores)
function sync-env() {
    local file=".env"
    local example=".env.example"

    if [[ ! -f "$file" ]]; then
        echo -e "\033[1;31mError:\033[0m .env file not found."
        return 1
    fi

    # Create example file if it doesn't exist
    [[ ! -f "$example" ]] && touch "$example"

    echo -e "\033[1;34m🔄 Syncing .env.example...\033[0m"

    # Read .env line by line
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "$line" ]]; then
            continue
        fi

        if [[ "$line" == *"="* ]]; then
            key=$(echo "$line" | cut -d '=' -f 1 | xargs)
            if ! grep -q "^${key}=" "$example"; then
                echo "${key}=" >> "$example"
                echo -e "  \033[1;32m+ Added:\033[0m $key"
            fi
        fi
    done < "$file"
    
    echo -e "\033[1;32m✅ .env.example is up to date.\033[0m"

    # --- Linting ---
    if command -v dotenv-linter >/dev/null 2>&1; then
        echo -e "\033[1;34m🔍 Linting .env and .env.example...\033[0m"
        # En v4.0.0 el comando por defecto para revisar es 'check' o pasar los archivos directamente
        # Si da error como subcomando, usamos la sintaxis explícita.
        dotenv-linter check "$file" "$example"
    fi
}
