#!/bin/sh
set -e

# echo "Exit intently" && exit 1

# configuration
# git ssh

# install:
# - vim vundle
# - zsh
# - oh-my-zsh

# soft link configurations from .dotfiles to $HOME
softLinkConfigs=(
    ".zshrc"
    ".vimrc"
    ".tmux.conf"
    ".gitignore_global"
    ".gitconfig"
)
for f in ${softLinkConfigs[*]}
do
    ln -s -f $HOME/.dotfiles/$f $HOME/$f
done
