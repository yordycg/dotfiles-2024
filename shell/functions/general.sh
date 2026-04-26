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
