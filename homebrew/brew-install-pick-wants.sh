#!/usr/bin/env bash

# Description: A script to interactively select and install brew formula using Homebrew and fzf.
# source: https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e?permalink_comment_id=5403665#gistcomment-5403665

# Enable strict error handling
set -euo pipefail

# Constants
FZF_PROMPT="Select Formulas: "
FZF_HEIGHT="60%"
FZF_LAYOUT="reverse"

# Colors
BLACK='\033[0;30m'  # Black
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
YELLOW='\033[0;33m' # Yellow
BLUE='\033[0;34m'   # Blue
PURPLE='\033[0;35m' # Purple
CYAN='\033[0;36m'   # Cyan
NC='\033[0m'        # Text Reset

# Function to check if a command is installed
is_command_installed() {
  command -v "$1" &>/dev/null
}

# Function to print a step message
print_step() {
  echo -e "\n${CYAN}➜ ${1}${NC}\n"
}

# Function to print a success message
print_success() {
  echo -e "\n${GREEN}✅ ${1}${NC}\n"
}

# Function to print a warning message
print_warn() {
  echo -e "${YELLOW}[Warn] ${1}${NC}"
}

# Function to print an error message and exit
print_error() {
  echo -e "${RED}❗️${1}${NC}"
  exit 1
}

# Function to check for dependencies
check_dependencies() {
  local dependencies=("brew" "fzf")

  for dep in "${dependencies[@]}"; do
    if ! is_command_installed "$dep"; then
      print_warn "$dep is not installed."
      if [[ "$dep" == "brew" ]]; then
        print_warn "Please install Homebrew first: https://brew.sh"
      elif [[ "$dep" == "fzf" ]]; then
        print_step "Installing fzf..."
        brew install fzf
      fi
      exit 1
    fi
  done
}

# Function to fetch all formulas in Brewfile
fetch_formulas() {
  cat Brewfile | grep "brew " | awk '{ gsub(/"/, "", $2); print $2 }'
}

# Function to select formulas interactively using fzf
select_formulas() {
  local formulas="$1"
  echo "$formulas" | fzf --multi --prompt="$FZF_PROMPT" --height="$FZF_HEIGHT" --layout="$FZF_LAYOUT"
}

# Function to install selected formulas
install_formulas() {
  local selected_formulas="$1"
  if [[ -z "$selected_formulas" ]]; then
    print_warn "No formulas selected. Exiting."
    exit 0
  fi

  print_step "Installing selected formulas ..."
  # Use a while loop to handle formula names with spaces
  echo "$selected_formulas" | while read -r formula; do
    echo -e "Installing $formula..."
    if brew install "$formula"; then
      print_success "Successfully installed $formula."
    else
      print_warn "Failed to install $formula."
    fi
  done
}

# Main function to orchestrate the script
main() {
  print_step "Select the formulas you want to install (use TAB to select multiple):"

  check_dependencies

  local formulas
  formulas=$(fetch_formulas)
  if [[ -z "$formulas" ]]; then
    print_error "No formulas found. Please ensure Brewfile is up to date."
  fi

  local selected_formulas
  selected_formulas=$(select_formulas "$formulas")

  install_formulas "$selected_formulas"
}

# Run the script
main
