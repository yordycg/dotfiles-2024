#!/usr/bin/env zsh

# --- [py] Auto-activate Python Virtual Environment (.venv) ---
# Detects .venv in the current directory when changing paths.

function _python_venv_auto_activate() {
    # If we are in a virtualenv and no .venv is found in the current path, deactivate.
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if [[ ! -d ".venv" ]] || [[ "$VIRTUAL_ENV" != "$(pwd)/.venv" ]]; then
            deactivate 2>/dev/null
        fi
    fi

    # If we are NOT in a virtualenv and a .venv exists, activate it.
    if [[ -z "$VIRTUAL_ENV" ]] && [[ -d ".venv" ]]; then
        if [[ -f ".venv/bin/activate" ]]; then
            source .venv/bin/activate
        fi
    fi
}

# Add the function to the chpwd hook (Zsh)
autoload -U add-zsh-hook
add-zsh-hook chpwd _python_venv_auto_activate

# Run once on startup in case we are already in a directory with .venv
_python_venv_auto_activate

# --- [py] Create and Activate Virtual Environment (venv) ---
function venv() {
    if [[ -d ".venv" ]]; then
        echo -e "\033[1;33m⚠️  El entorno .venv ya existe.\033[0m"
    else
        echo -e "\033[1;34m📦 Creando entorno virtual en .venv...\033[0m"
        python3 -m venv .venv
        
        # Añadir a .gitignore si es necesario
        if gi_add ".venv/" "Python Virtual Environment"; then
            echo -e "\033[1;32m✓ .venv añadido a .gitignore\033[0m"
        fi
        
        echo -e "\033[1;32m✅ Entorno creado correctamente.\033[0m"
    fi

    # Activar siempre (si existe)
    if [[ -f ".venv/bin/activate" ]]; then
        source .venv/bin/activate
        echo -e "\033[1;34m🐍 Entorno activado.\033[0m"
    fi
}
