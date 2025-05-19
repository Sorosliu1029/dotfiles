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

echo "--> install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ $machine == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ $machine == "Mac" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "--> install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

if [[ $machine == "Linux" ]]; then
  echo "--> update and upgrade apt"
  sudo apt update && sudo apt upgrade

  echo "--> install necessary software"
  sudo apt install -y git vim zsh net-tools tmux curl wget

  echo "--> change default shell to zsh"
  chsh -s "$(which zsh)"

  echo "--> install homebrew bundled apps"
  brew bundle --file ./homebrew/ubuntu.Brewfile

elif [[ $machine == "Mac" ]]; then
  echo "--> install homebrew bundled apps"
  brew bundle --file ./homebrew/Brewfile

  echo "--> install rime input method"
  mkdir -p ~/.rime
  cd ~/.rime
  curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | bash -s -- Sorosliu1029/rime-conf/my-double-pinyin-flypy-packages.conf
  cd - || exit

fi

echo "--> install tpm (Tmux Plugin Manager)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Congratulatoins, your machine is set up!"
