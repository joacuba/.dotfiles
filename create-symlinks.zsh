#!/bin/zsh

[ -e ~/.vimrc ] && rm ~/.vimrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc

[ -e ~/.config/nvim ] && rm -rf ~/.config/nvim
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim

[ -e ~/.config/alacritty ] && rm -rf ~/.config/alacritty
ln -s ~/.dotfiles/.config/alacritty ~/.config/alacritty

[ -e ~/.config/ghostty ] && rm -rf ~/.config/ghostty
ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty

[ -e ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Symlinks created successfully!"
