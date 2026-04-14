###############################################################################
# SHELL FUNCTIONS LOADER
###############################################################################
# Este archivo carga dinámicamente todos los módulos de funciones en shell/functions/

if [ -d "$DOTFILES/shell/functions" ]; then
    for func_file in "$DOTFILES/shell/functions"/*.sh; do
        if [ -f "$func_file" ]; then
            source "$func_file"
        fi
    done
fi
