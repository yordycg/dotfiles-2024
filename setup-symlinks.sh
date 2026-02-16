# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir -p ~/.config

# If Linux...
ln -s $DOTFILES/os/linux/tmux ~/.config/
ln -s $DOTFILES/os/cross-platform/wezterm ~/.config/
ln -s $DOTFILES/os/cross-platform/starship/ ~/.config/
ln -fs $DOTFILES/git/.gitconfig ~/.gitconfig
ln -fs $DOTFILES/shell/zsh/.zshrc ~/.zshrc

# Sheldon config
mkdir -p ~/.config/sheldon
ln -sf "$DOTFILES/shell/zsh/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml

## cpp
ln -sf $DOTFILES/os/cross-platform/clangd/.clang-format ~/.clang-format
ln -sf $DOTFILES/os/cross-platform/clangd/.clangd ~/.clangd

# If Windows...

# If macOs...
