#!/bin/bash
set -e

echo "--> update and upgrade apt"
sudo apt update && sudo apt upgrade

echo "--> install necessary softwares"
sudo apt install -y git vim zsh gnome-tweak-tool openssh-server net-tools tmux curl wget

echo "--> change default shell to zsh"
chsh -s $(which zsh)

echo "Congratulatoins, your ubuntu is set up!"
