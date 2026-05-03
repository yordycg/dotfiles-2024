# ----------------------------------------------------------------------
# JUSTFILE - Universal Dotfiles Management (Linux & Windows)
# ----------------------------------------------------------------------

# Configuración de Just
set shell := ["bash", "-uc"]
set windows-shell := ["powershell.exe", "-NoProfile", "-Command"]

# Variables de detección de sistema
os := os_family()
is_windows := if os == "windows" { "true" } else { "false" }

# Comandos dependientes del OS
update_cmd := if os == "windows" { 'pwsh.exe -File ./os/windows/setup-window.ps1 -Task Scoop' } else { 'yay -Syu; just sync-pkgs' }
links_cmd  := if os == "windows" { 'pwsh.exe -File ./os/windows/setup-window.ps1 -Task Links' } else { './scripts/setup-symlinks.sh' }
clean_cmd  := if os == "windows" { "pwsh.exe -Command cleanup" } else { "cleanup" }
install_cmd := if os == "windows" { "pwsh.exe -File ./install-windows.ps1" } else { "bash ./install.sh" }

# Mostrar lista de comandos por defecto
default:
    @just --list --list-heading "🚀 Dotfiles ({{os}}) - Comandos disponibles:\n"

# --- Sistema y Mantenimiento ---

[group('sys')]
update:
    @{{update_cmd}}

[group('sys')]
sync-pkgs:
    @if [ "{{os}}" != "windows" ]; then pkg-sync; else echo "⚠️ Sync-pkgs no disponible en Windows."; fi

[group('sys')]
links:
    @echo "🔗 Refrescando enlaces simbólicos..."
    @{{links_cmd}}

# --- Apariencia (Interactivos) ---

[group('ui')]
theme:
    @if [ "{{os}}" != "windows" ]; then theme-picker; else echo "🎨 No disponible en Windows."; fi

[group('ui')]
wallpaper:
    @if [ "{{os}}" != "windows" ]; then wallpaper-picker; else echo "🖼️ No disponible en Windows."; fi

# --- Herramientas Dev ---

[group('dev')]
init-env:
    @if [ "{{os}}" != "windows" ]; then gen-env; else echo "⚠️ gen-env debe ejecutarse en PowerShell."; fi

[group('dev')]
clean:
    @echo "🧹 Limpiando archivos temporales y caché..."
    @{{clean_cmd}}

# --- Instalación y Setup ---

[group('install')]
install:
    @{{install_cmd}}

[group('install')]
setup-zed:
    @if [ "{{os}}" != "windows" ]; then zed-setup; else echo "⚙️ Zed se configura vía symlinks."; fi
