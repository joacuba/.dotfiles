#!/bin/zsh

vimrc_path="~/.vimrc"
nvim_config_path="~/.config/nvim/"
alacritty_config_path="~/.config/alacritty"
ghostty_config_path="~/.config/ghostty"
tmux_config_path="~/.tmux.conf"
ideavimrc_path="~/.ideavimrc"

cwp="" # means: current_working_path

case "$1" in
  all|-a)
    echo "Creating all the symlinks"
    if [ -e ~/.vimrc ] && rm ~/.vimrc; then # check the if the file exist, if exist remove the file
      echo "Removing previous ./vimrc symlink"
    fi
    if ln -s ~/.dotfiles/.vimrc ~/.vimrc; then # create a symlink
      echo "./vimrc symlink created successfully"
    else
      echo "Error creating ./vimrc symlink"
    fi

    if [ -e ~/.config/nvim ] && rm -rf ~/.config/nvim; then
      echo "Removing previous ~/.config/nvim symlink"
    fi
    if ln -s ~/.dotfiles/.config/nvim ~/.config/nvim; then
      echo "~/.config/nvim symlink created successfully"
    else
      echo "Error creating ~/.config/nvim symlink"
    fi

    if [ -e ~/.config/alacritty ] && rm -rf ~/.config/alacritty; then
      echo "Removing previous ~/.config/alacritty symlink"
    fi
    if ln -s ~/.dotfiles/.config/alacritty ~/.config/alacritty; then
      echo "~/.config/alacritty symlink created successfully"
    else
      echo "Error creating ~/.config/alacritty symlink"
    fi

    cwp="$ghostty_config_path"
    if [ -e ~/.config/ghostty ] && rm -rf ~/.config/ghostty; then
      echo "Removing previous $cwp symlink"
    fi
    if ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty; then
      echo "$cwp symlink created successfully"
    else
      echo "Error creating $cwp symlink"
    fi

    cwp="$tmux_config_path"
    if [ -e ~/.tmux.conf ] && rm ~/.tmux.conf; then
      echo "Removing previous $cwp symlink"
    fi
    if ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf; then
      echo "$cwp symlink created successfully"
    else
      echo "Error creating $cwp symlink"
    fi

    cwp="$ideavimrc_path"
    if [ -e ~/.ideavimrc ] && rm ~/.ideavimrc; then
      echo "Removing previous $cwp symlink"
    fi
    if ln -s ~/.dotfiles/.ideavimrc ~/.ideavimrc; then
      echo "$cwp symlink created successfully"
    else
      echo "Error creating $cwp symlink"
    fi
    ;;
  --vim)
    echo "Creating just the .vimrc file symlink"
    cwp="$vimrc_path"
    if [ -e "$cwp" ] && rm "$cwp"; then
      echo "Removing previous $cwp symlink"
    fi
    if ln -s ~/.dotfiles/.vimrc "$cwp"; then
      echo "$cwp symlink created successfully"
    else
      echo "Error creating $cwp symlink"
    fi
    ;;
  --idea)
    cwp="$ideavimrc_path"
    if [ -e ~/.ideavimrc ] && rm ~/.ideavimrc; then
      echo "Removing previous $cwp symlink"
    fi
    if ln -s ~/.dotfiles/.ideavimrc ~/.ideavimrc; then
      echo "$cwp symlink created successfully"
    else
      echo "Error creating $cwp symlink"
    fi
    ;;
  *)
    echo "--all or -a Set all symlinks"
    echo "--vim       Set vimrc symlink"
    echo "--idea      Set ideavimrc symlink"
    ;;
esac
