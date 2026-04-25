###############################################################################
# GENERAL UTILS
###############################################################################

# Crear y entrar a un directorio
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Navegar niveles hacia arriba (up 3)
function up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++)); do
    d=$d"../"
  done
  cd $d
}

# Extractor universal
function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       split -b "$1"    ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Limpiar archivos temporales de desarrollo
function cleanup() {
  find . -type d -name "__pycache__" -exec rm -rf {} +
  find . -type d -name "node_modules" -exec rm -rf {} +
  find . -type d -name ".pytest_cache" -exec rm -rf {} +
  find . -type d -name ".mypy_cache" -exec rm -rf {} +
  find . -type d -name "build" -exec rm -rf {} +
  echo "Limpieza de desarrollo completada."
}

# Sincronizar listas de paquetes instalados con dotfiles
function pkg-sync() {
  local pkg_dir="$DOTFILES/os/linux/post-install-arch/packages"
  local official_list="$pkg_dir/pkglist-official.txt"
  local aur_list="$pkg_dir/pkglist-aur.txt"

  if [ ! -d "$pkg_dir" ]; then
    mkdir -p "$pkg_dir"
  fi

  # Exportar paquetes oficiales (instalados explícitamente, no dependencias)
  pacman -Qqen > "$official_list"
  # Exportar paquetes del AUR/Locales
  pacman -Qqem > "$aur_list"

  echo "✅ Listas de paquetes actualizadas en: $pkg_dir"
  echo "📦 Oficiales: $(wc -l < "$official_list")"
  echo "📦 AUR: $(wc -l < "$aur_list")"
}

# Generador inteligente de archivos .env para proyectos
function gen-env() {
    local type=$1
    local file=".env"

    if [[ -z "$type" ]]; then
        type=$(echo -e "mysql\npostgres\nsqlserver" | fzf --prompt="󰆼 Select .env template: " --height=40% --layout=reverse --border)
        [[ -z "$type" ]] && return 0
    fi

    if [[ -f "$file" ]]; then
        echo -en "\033[1;33m⚠️  The .env file already exists. Overwrite? (y/n): \033[0m"
        read -r res
        [[ "$res" != "y" ]] && return 0
    fi

    # Sanitize current folder name for DB_NAME
    local project_name=$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]//g')
    local random_pass=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 12)

    case "$type" in
        mysql)
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_TYPE=mysql
DB_NAME=${project_name}_db
DB_USER=admin
DB_PASS=${random_pass}
DB_PORT=3306
EOF
            ;;
        postgres)
            cat <<EOF > "$file"
# --- Database Configuration ---
DB_TYPE=postgres
DB_NAME=${project_name}_db
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
        *)
            echo -e "\033[1;31mError:\033[0m Template for '$type' not found."
            return 1
            ;;
    esac

    # --- Git Protection ---
    if [[ -d ".git" || -f ".gitignore" ]]; then
        if ! grep -q "^.env" .gitignore 2>/dev/null; then
            echo -e "\033[1;33m🛡️  Adding .env to .gitignore for security...\033[0m"
            echo -e "\n# Security\n.env" >> .gitignore
        fi
    fi

    echo -e "\033[1;32m✅ .env generated for $type successfully.\033[0m"
    [[ "$type" != "sqlserver" ]] && echo -e "\033[1;34m󰆼 DB Name:\033[0m ${project_name}_db"
    echo -e "\033[1;34m🔑 Password:\033[0m $([[ "$type" == "sqlserver" ]] && echo "$sql_pass" || echo "$random_pass")"
}
