#!/bin/bash
set -e

echo "--> update and upgrade apt"
sudo apt update && sudo apt upgrade

echo "--> install necessary softwares"
sudo apt install -y git vim zsh gnome-tweak-tool openssh-server net-tools tmux curl wget

echo "--> change default shell to zsh"
chsh -s $(which zsh)

echo "--> soft link configurations from .dotfiles to $HOME"
softLinkConfigs=(
    ".zshrc"
    ".vimrc"
    ".tmux.conf"
    ".gitignore_global"
    ".gitconfig"
    ".npmrc"
    ".condarc"
)
for f in ${softLinkConfigs[*]}
do
    ln -s -f $HOME/.dotfiles/$f $HOME/$f
done


echo "Congratulatoins, your ubuntu is set up!"
