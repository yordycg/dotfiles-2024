###############################################################################
# PROJECT MANAGEMENT & SCAFFOLDING
###############################################################################

# Crear un nuevo proyecto desde una plantilla
function new() {
    local templates_dir="$DOTFILES/projects/templates"
    local base_projects_dir="$PERSONAL_PATH"
    
    if [[ ! -d "$templates_dir" ]]; then
        echo -e "\033[1;31mError:\033[0m Templates directory not found at $templates_dir"
        return 1
    fi

    # 1. Seleccionar plantilla con FZF
    local type=$(command ls -1 "$templates_dir" | fzf --prompt="🏗️  Select Project Template: " --height=40% --layout=reverse --border)
    [[ -z "$type" ]] && return 0

    # 2. Decidir dónde crear el proyecto
    local current_dir=$(pwd)
    local target_dir="$current_dir"

    # Sugerir personal/ si estamos en dotfiles o directamente en workspace
    if [[ "$current_dir" == "$DOTFILES" || "$current_dir" == "$WORKSPACE_PATH" ]]; then
        echo -e "\033[1;33m⚠️  Current directory is a base path ($current_dir).\033[0m"
        echo -en "\033[1;34m📂 Create project in $base_projects_dir? (y/n): \033[0m"
        read -r res
        if [[ "$res" == "y" ]]; then
            mkdir -p "$base_projects_dir"
            target_dir="$base_projects_dir"
        fi
    fi

    # 3. Ejecutar Cookiecutter
    echo -e "\033[1;34m🚀 Initializing '$type' template in $target_dir...\033[0m"
    echo -e "\033[1;30m(Follow the prompts below to configure your project)\033[0m\n"
    
    # Ejecutamos cookiecutter
    if cookiecutter "$templates_dir/$type" -o "$target_dir"; then
        echo -e "\n\033[1;32m✅ Project created successfully.\033[0m"
        
        # Encontrar la carpeta creada (buscamos la más joven usando command ls para evitar eza)
        local new_folder=$(command ls -dt "$target_dir"/*/ | head -1)
        
        if [[ -n "$new_folder" ]]; then
            echo -e "\033[1;34m📂 Entering $new_folder...\033[0m"
            cd "$new_folder" || return
            
            # Inicializar Git y .env
            git init -q
            gen-env empty
        fi
    else
        echo -e "\033[1;31m❌ Project creation failed.\033[0m"
        return 1
    fi
}

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
DB_TYPE=mysql
DB_NAME=${db_name}_db
DB_USER=admin
DB_PASS=${random_pass}
DB_PORT=3306
EOF
            ;;
        postgres)
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_TYPE=postgres
DB_NAME=${db_name}_db
DB_USER=admin
DB_PASS=${random_pass}
DB_PORT=5432
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
        if ! grep -q "^\.env$" .gitignore 2>/dev/null; then
            echo -e "\033[1;33m🛡️  Adding .env to .gitignore for security...\033[0m"
            echo -e "\n# Security\n.env" >> .gitignore
        fi
        
        # Ensure .env.example is NOT ignored
        if grep -q "^\.env.example$" .gitignore 2>/dev/null; then
            echo -e "\033[1;33m🔓 Removing .env.example from .gitignore (it should be public)...\033[0m"
            sed -i '/^\.env\.example$/d' .gitignore
        fi
    fi

    echo -e "\033[1;32m✅ .env generated for $type successfully.\033[0m"
    [[ "$type" != "sqlserver" && "$type" != "empty" ]] && echo -e "\033[1;34m󰆼 DB Name:\033[0m ${project_name}_db"
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
