unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  *)          echo "Unknown Machine:${unameOut}"; exit 0;;
esac

if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ $machine == "Linux" ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ $machine == "Mac" ]]; then
      # Homebrew Apple Silicon, place before `plugins`
      eval "$(/opt/homebrew/bin/brew shellenv)"
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
# ZSH_THEME="powerlevel10k/powerlevel10k"
source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

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
  iterm2
  nvm
  asdf
  zsh-syntax-highlighting # zsh-syntax-highlighting MUST be the last plugin
)

source $ZSH/oh-my-zsh.sh

# Manually set language environment
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# Editor setting
export EDITOR='nvim'

# vim style key binding
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# custom alias
alias c="clear"
alias gs="gst"
alias lg="lazygit"
alias vi="nvim"
alias vim="nvim"
alias ":q"="exit"
if [[ -L $HOME/.zshrc ]]; then
  __p=$(readlink $HOME/.zshrc)
  __d=$(dirname $__p)
  [[ -f "$__d/${machine:l}.zsh" ]] && source "$__d/${machine:l}.zsh"
  unset __p __d
fi

# Configuration for zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan"

# Homebrew settings
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
# Homebrew end

# Autojump
[[ -f "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh" ]] && source "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh"
# autojump end

# p10k: To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh
# p10k end

# conda initialize
# !! Contents within this block are managed by 'conda init' !!
if [[ $machine == "Linux" ]]; then
    CONDA_PATH="$HOME/.anaconda3"
    __conda_setup="$('/home/soros/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
elif [[ $machine == "Mac" ]]; then
    CONDA_PATH="$HOME/miniconda3"
    __conda_setup="$('/Users/soros/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
fi
if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
else
    if [[ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]]; then source "$CONDA_PATH/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_PATH/bin:$PATH"
    fi
fi
unset CONDA_PATH
unset __conda_setup
# conda end

# goenv setting
[[ -z "${GOENV_ROOT:-}" ]] && eval "$(goenv init -)"
# goenv end

# pnpm (installed by homebrew)
export PNPM_HOME="$HOMEBREW_PREFIX/bin"
# pnpm end

# GHCup, main installer for the general purpose language Haskell
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env" # ghcup-env
# GHCup end

# Lazygit config folder
export XDG_CONFIG_HOME="$HOME/.config"
# Lazygit end

# DOOM emacs
if [[ $machine == "Mac" ]] && [[ ":$PATH:" != *":$HOME/.config/emacs/bin:"* ]]; then
  export PATH="$HOME/.config/emacs/bin:$PATH"
fi
# DOOM emacs end

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [[ $machine == "Mac" ]] && [[ -z "${SDKMAN_DIR:-}" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
# sdkman end

# unset, to prevent polluting
unset machine
