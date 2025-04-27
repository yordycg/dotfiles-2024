# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir ~/.config

# If Linux...
ln -s $DOTFILES/os/linux/tmux ~/.config/
ln -s $DOTFILES/os/cross-platform/wezterm ~/.config/
ln -s $DOTFILES/os/cross-platform/starship/ ~/.config/
ln -fs $DOTFILES/git/.gitconfig ~/.gitconfig
ln -fs $DOTFILES/shell/zsh/.zshrc ~/.zshrc

## cpp
ln -sf $DOTFILES/os/cross-platform/clangd/.clang-format ~/.clang-format
ln -sf $DOTFILES/os/cross-platform/clangd/.clangd ~/.clangd

# If Windows...

# If macOs...
