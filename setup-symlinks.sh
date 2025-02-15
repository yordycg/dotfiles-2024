# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir ~/.config

# If Linux...
ln -s $DOTFILES/os/linux/tmux ~/.config/
ln -s $DOTFILES/os/cross-platform/wezterm ~/.config/
ln -s $DOTFILES/os/cross-platform/starship/ ~/.config/
ln -fs $DOTFILES/git/.gitconfig ~/.gitconfig
ln -fs $DOTFILES/shell/zsh/.zshrc ~/.zshrc

# If Windows...

# If macOs...
