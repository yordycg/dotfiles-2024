#!/bin/bash
# Fish installation script

echo "Installing Fish Shell..."

# 1.- Detectar distribucion...
if command -v apt >/dev/null 2>&1; then
  # Ubuntu/Debian
  sudo apt-add-repository ppa:fish-shell/release-3 -y
  sudo apt update
  sudo apt install fish -y
elif command -v pacman >/dev/null 2>&1; then
  # Arch
  sudo pacman -S fish --noconfirm
elif command -v brew >/dev/null 2>&1; then
  # macOS/Homebrew
  brew install fish
else
  echo "Error: Package manager not supported. Please install manually."
  exit 1
fi

# 1.1.- Verificar instalacion...
if ! command -v fish >/dev/null 2>&1; then
  echo "Error: Fish installation failed"
  exit 1
fi

echo "Fish installed successfully: $(fish --version)"

# 2.- Agregar FISH a shells validos
FISH_PATH=$(which fish)
if ! grep -q "$FISH_PATH" /etc/shells; then
  echo "Adding Fish to /etc/shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

# 3.- Instalar configuracion...
echo "... Installing Fish configuration..."
fish "$DOTFILES/shell/fish/install.fish"

echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Test Fish: fish"
echo "2. If you like it, make it default: chsh -s $FISH_PATH"
echo "3. Customize: fish_config"

