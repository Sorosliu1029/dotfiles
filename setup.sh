#!/usr/bin/env bash
# Bootstrap a fresh machine. Safe to re-run: each step skips if already done.

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

# clone_once <url> <dir>
clone_once() {
  if [[ -d "$2" ]]; then
    echo "    already present: $2"
  else
    git clone "$1" "$2"
  fi
}

if [[ $machine == "Linux" ]]; then
  echo "--> update and upgrade apt"
  sudo apt update && sudo apt upgrade -y

  echo "--> install necessary software"
  sudo apt install -y git vim zsh net-tools tmux curl wget

  if [[ "$(basename "$SHELL")" != "zsh" ]]; then
    echo "--> change default shell to zsh"
    chsh -s "$(which zsh)"
  fi
fi

echo "--> install Homebrew"
if command -v brew >/dev/null 2>&1; then
  echo "    already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ $machine == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ $machine == "Mac" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "--> install homebrew bundled apps"
if [[ $machine == "Linux" ]]; then
  brew bundle --file ./homebrew/ubuntu.Brewfile
elif [[ $machine == "Mac" ]]; then
  brew bundle --file ./homebrew/Brewfile
fi

# Stow before oh-my-zsh so ~/.zshrc is already our symlink; KEEP_ZSHRC stops
# the installer from replacing it.
echo "--> stow dotfiles"
./stow.sh
if [[ -x "$HOME/.dotfiles_private/stow.sh" ]]; then
  "$HOME/.dotfiles_private/stow.sh"
else
  echo "    ~/.dotfiles_private not found; clone it and run its stow.sh"
fi

echo "--> install oh-my-zsh"
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "    already installed"
else
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "--> install oh-my-zsh plugins"
zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_once https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
clone_once https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"
if [[ $machine == "Mac" ]]; then
  echo "--> install rime input method"
  if [[ -d "$HOME/Library/Rime" ]]; then
    (
      cd "$HOME/Library/Rime" || exit 1
      curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | bash -s -- Sorosliu1029/rime-conf/my-double-pinyin-flypy-packages.conf
      cp ./plum/package/Sorosliu1029/conf/*.custom.yaml ./plum/package/Sorosliu1029/conf/*.lua ./
    )
  else
    echo "    ~/Library/Rime not found; install Squirrel (brew bundle) and re-run"
  fi
fi

echo "--> install tpm (Tmux Plugin Manager)"
clone_once https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo "Congratulations, your machine is set up!"
