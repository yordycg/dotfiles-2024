#!/usr/bin/env fish
# Fish dotfiles installer

set -l FISH_CONFIG_DIR "$HOME/.config/fish"
set -l DOTFILES_FISH "$DOTFILES/shell/fish"

echo "Installing Fish configuration..."

# 1.- Crear backup si existe config previa.
if test -d "$FISH_CONFIG_DIR"
  echo "Backing up existing Fish config..."
  mv "$FISH_CONFIG_DIR" "$FISH_CONFIG_DIR.backup."(date +%Y%m%d_%H%M%S)
end

# 2.- Crear directorio de config.
mkdir -p "$FISH_CONFIG_DIR"

# 3.- Crear enlaces simbolicos.
echo "Creating symlinks..."

# Config principal.
ln -sf "$DOTFILES_FISH/config.fish" "$FISH_CONFIG_DIR/config.fish"

# Directorios.
ln -sf "$DOTFILES_FISH/functions" "$FISH_CONFIG_DIR/functions"
ln -sf "$DOTFILES_FISH/conf.d" "$FISH_CONFIG_DIR/conf.d"
ln -sf "$DOTFILES_FISH/completions" "$FISH_CONFIG_DIR/completions"

# 4.- Instalar Fisher si no esta instalado.
if not functions -1 fisher
  echo "Installing Fisher..."
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
  fisher install jorgebucaran/fisher
end

# 5.- Instalar plugins desde fishfile.
if test -f "$DOTFILES_FISH/fishfile"
  echo "Installing plugins..."
  while read -la plugin
    if test -n "$plugin"
      fisher install $plugin
    end
  end < "$DOTFILES_FISH/fishfile"
end

# 6.- Mensaje de despedida.
echo "Fish configuration installed!"
echo "Run 'fish' to start using your new configuration"
echo "run 'fish_config' for web-based customization"
