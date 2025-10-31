#!/usr/bin/env bash
# ----------------------------------------------------------------------
# Cross-platform bootstrap for Arch/Debian/macOS using Homebrew and chezmoi
# Features:
# 1. Installs Homebrew if missing
# 2. Installs chezmoi via Homebrew
# 3. Prompts user before initializing chezmoi
# 4. Allows user to enter GitHub username for dotfiles repo
# 5. Fallback: offers to install chezmoi via get.chezmoi.io if brew fails
# ----------------------------------------------------------------------

set -euo pipefail

# Function: Install Homebrew
install_brew() {
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed."
    return 0
  fi

  echo "Homebrew not found. Attempting to install..."
  if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    echo "Homebrew installed successfully."
    # Set environment variables for Linuxbrew/macOS
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null || \
           /opt/homebrew/bin/brew shellenv 2>/dev/null || \
           /usr/local/bin/brew shellenv 2>/dev/null)"
  else
    echo "Homebrew installation failed."
    return 1
  fi
}

# Function: Install chezmoi via brew
install_chezmoi_brew() {
  if ! command -v chezmoi >/dev/null 2>&1; then
    echo "Installing chezmoi via Homebrew..."
    brew install chezmoi
  else
    echo "chezmoi already installed."
  fi
}

# Function: Fallback installation via get.chezmoi.io
fallback_install_chezmoi() {
  echo "Would you like to install chezmoi directly from its official binary? [y/N]"
  read -r fallback_choice
  if [[ "$fallback_choice" =~ ^[Yy]$ ]]; then
    sh -c "$(curl -fsLS get.chezmoi.io)"
  else
    echo "Skipping chezmoi installation."
    exit 1
  fi
}

# Function: Prompt for GitHub username for dotfiles
prompt_dotfiles_user() {
  echo "Enter your GitHub username for chezmoi dotfiles repo (e.g., yourusername):"
  read -r github_user
  echo "$github_user"
}

# Function: Initialize chezmoi
init_chezmoi() {
  github_user="$1"
  echo "Do you want to run 'chezmoi init --apply $github_user'? [y/N]"
  read -r apply_choice
  if [[ "$apply_choice" =~ ^[Yy]$ ]]; then
    chezmoi init --apply "$github_user"
  else
    echo "Skipped chezmoi initialization."
  fi
}

# ---------------------- Main Script Flow ----------------------------

# Step 1: Ensure Homebrew is installed
if ! install_brew; then
  echo "Homebrew installation failed. Offering fallback for chezmoi..."
  fallback_install_chezmoi
fi

# Step 2: Install chezmoi via Homebrew
install_chezmoi_brew

# Step 3: Prompt for GitHub username and optionally initialize chezmoi
github_user=$(prompt_dotfiles_user)
init_chezmoi "$github_user"

echo "Bootstrap complete."
