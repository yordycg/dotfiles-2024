# ----------------------------------------------------------------------
# JUSTFILE - Universal Dotfiles Management (Linux & Windows)
# ----------------------------------------------------------------------

# Configuración de Just
set shell := ["bash", "-uc"]
set windows-shell := ["powershell.exe", "-NoProfile", "-Command"]

# Variables de detección de sistema
os := os_family()
is_windows := if os == "windows" { "true" } else { "false" }

# Mostrar lista de comandos por defecto
default:
    @just --list --list-heading "🚀 Dotfiles ({{os}}) - Comandos disponibles:\n"

# --- Sistema y Mantenimiento ---

[group('sys')]
update:
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "🚀 Actualizando Scoop y aplicaciones..."; \
        scoop update "*"; \
    else \
        echo "📦 Actualizando paquetes de Linux (Yay)..."; \
        yay -Syu; \
        just sync-pkgs; \
    fi

[group('sys')]
sync-pkgs:
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "⚠️  Sync-pkgs no está implementado para Windows (usa Scoop directamente)."; \
    else \
        pkg-sync; \
    fi

[group('sys')]
links:
    @echo "🔗 Refrescando enlaces simbólicos..."
    @if [ "{{is_windows}}" == "true" ]; then \
        pwsh.exe -File ./os/windows/setup-window.ps1; \
    else \
        ./scripts/setup-symlinks.sh; \
    fi

# --- Apariencia (Interactivos) ---

[group('ui')]
theme:
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "🎨 selector de tema no disponible en Windows nativo."; \
    else \
        theme-picker; \
    fi

[group('ui')]
wallpaper:
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "🖼️  Selector de wallpaper no disponible en Windows."; \
    else \
        wallpaper-picker; \
    fi

# --- Herramientas Dev ---

[group('dev')]
init-env:
    @echo "⚙️  Inicializando entorno de proyecto (.env)..."
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "⚠️  gen-env debe ejecutarse dentro de la shell de PowerShell."; \
    else \
        gen-env; \
    fi

[group('dev')]
clean:
    @echo "🧹 Limpiando archivos temporales y caché..."
    @if [ "{{is_windows}}" == "true" ]; then \
        pwsh.exe -Command "cleanup"; \
    else \
        cleanup; \
    fi

# --- Instalación y Setup ---

[group('install')]
install:
    @if [ "{{is_windows}}" == "true" ]; then \
        pwsh.exe -File ./install-windows.ps1; \
    else \
        bash ./install.sh; \
    fi

[group('install')]
setup-zed:
    @if [ "{{is_windows}}" == "true" ]; then \
        echo "⚙️  Zed se configura mediante enlaces simbólicos (just links)."; \
    else \
        zed-setup; \
    fi
