#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

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
  stow -vv -R -t "$HOME" --dotfiles stow bash btop conda gh-copilot git p10k lazygit nvim \
    tmux vim zsh jupyter readline
elif [[ $machine == "Mac" ]]; then
  stow -vv -R -t "$HOME" --dotfiles stow bash btop conda doom gh-copilot git gnupg lazygit nvim \
    p10k sioyek spotify-player tmux vim zsh karabiner readline jupyter
fi

# gh: unfolded so ~/.dotfiles_private can add hosts.yml into ~/.config/gh
stow -vv -R -t "$HOME" --dotfiles --no-folding gh
