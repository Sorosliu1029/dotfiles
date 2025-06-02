#!/usr/bin/env bash

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*) machine=Linux ;;
  Darwin*) machine=Mac ;;
  *)
    echo "Unknown Machine:${unameOut}"
    exit 0
    ;;
esac

if [[ $machine == "Linux" ]]; then
  stow -vv --dotfiles stow bash btop conda gh gh-copilot git p10k lazygit nvim \
    tmux vim zsh
elif [[ $machine == "Mac" ]]; then
  stow -vv --dotfiles stow bash btop conda doom gh gh-copilot git gnupg lazygit nvim \
    p10k sioyek spotify-player tmux vim zsh karabiner npm
fi
