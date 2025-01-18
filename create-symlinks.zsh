#!/bin/zsh

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.config/nvim/ ~/.config/nvim
ln -s ~/.dotfiles/.config/alacritty / ~/.config/alacritty
ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Symlinks created successfully!"
