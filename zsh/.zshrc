unameOut="$(uname -a)"
case "${unameOut}" in
  *pace.gatech.edu*) machine=Pace;;
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  *)          echo "Unknown Machine:${unameOut}"; exit 0;;
esac

if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ $machine == "Linux" ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ $machine == "Mac" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ $machine == "Pace" ]]; then
      eval "$(~/.homebrew/bin/brew shellenv)"
  fi
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.
# recommended themes:fino, strung, agnoster, spaceship
if [[ $machine == "Pace" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

# p10k: To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ -f $HOME/.p10k.zsh ]] && source "$HOME/.p10k.zsh"
# p10k end

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion. Case sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=50
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autojump
  tmux
  zsh-autosuggestions
  colored-man-pages
  emoji
  fzf
  asdf
  eza
  zsh-syntax-highlighting # zsh-syntax-highlighting MUST be the last plugin
)
# Configuration for zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan"

source "$ZSH/oh-my-zsh.sh"

# Manually set language environment
if [[ $machine == "Pace" ]]; then
  export LANG=C
else
  export LANG=en_US.UTF-8
fi
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# Editor setting
export EDITOR='nvim'

# User config folder (used by lazygit, DOOM Emacs, etc)
export XDG_CONFIG_HOME="$HOME/.config"

# vim style key binding
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# custom alias
alias c="clear"
alias gs="gst"
alias lg="lazygit"
alias v="nvim"
alias vim="nvim"
alias ":q"="exit"
if [[ -L $HOME/.zshrc ]]; then
  __p=$(readlink "$HOME/.zshrc")
  __d=$(dirname "$__p")
  [[ -f "$HOME/$__d/${machine:l}.zsh" ]] && source "$HOME/$__d/${machine:l}.zsh"
  unset __p __d
fi

# Homebrew settings
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_UPDATE_REPORT_NEW=true
export HOMEBREW_NO_UPDATE_REPORT_FORMULAE=true
export HOMEBREW_NO_UPDATE_REPORT_CASKS=true
# Homebrew end

# conda initialize
if [[ $machine == "Linux" ]]; then
    eval "$('/home/soros/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
elif [[ $machine == "Mac" ]]; then
  eval "$(conda "shell.$(basename "${SHELL}")" hook)"
fi
# conda end

# GHCup, main installer for the general purpose language Haskell
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env" # ghcup-env
# GHCup end

# DOOM emacs
if [[ $machine == "Mac" ]] && [[ ":$PATH:" != *":$HOME/.emacs.d/bin:"* ]]; then
  export PATH="$HOME/.emacs.d/bin:$PATH"
fi
alias emacs="emacsclient --alternate-editor=\"\" -t"
# DOOM emacs end

# Cuda
if [[ $machine == "Linux" ]]; then
    export PATH="/usr/local/cuda/bin:$PATH"
fi
# Cuda end

if [[ $machine == "Pace" ]]; then
  export PERL5LIB=$HOMEBREW_PREFIX/lib/perl5/
  export PATH="$HOME/.nvim/bin:$HOME/.local/bin:$PATH"
fi

