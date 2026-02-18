#!/bin/bash

# Script to generate an SSH key and add it to GitHub via gh CLI.

set -e # Exit immediately if a command exits with a non-zero status.

echo "--- Starting GitHub SSH Key Automation ---"

# --- Configuration ---
SSH_KEY_NAME="id_ed25519_github"
SSH_DIR="$HOME/.ssh"
SSH_KEY_PATH="$SSH_DIR/$SSH_KEY_NAME"
SSH_KEY_PUB_PATH="$SSH_KEY_PATH.pub"
KEY_COMMENT="GitHub automation key for $(hostname)"
KEY_TITLE="GitHub Automation Key on $(hostname)" # Title displayed on GitHub

# --- 1. Check for gh CLI and authentication ---
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed."
    echo "Please install it from https://cli.github.com/ and try again."
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo "Error: Not authenticated with GitHub CLI."
    echo "Please run 'gh auth login' and try again."
    exit 1
fi
echo "GitHub CLI found and authenticated."

# --- 2. Create .ssh directory if it doesn't exist ---
if [ ! -d "$SSH_DIR" ]; then
    echo "Creating $SSH_DIR directory..."
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# --- 3. Generate SSH Key ---
if [ -f "$SSH_KEY_PATH" ]; then
    echo "Warning: SSH key '$SSH_KEY_NAME' already exists at '$SSH_KEY_PATH'."
    read -p "Do you want to overwrite it? (y/N): " overwrite_choice
    if [[ ! "$overwrite_choice" =~ ^[yY]$ ]]; then
        echo "Exiting without generating new key."
        exit 0
    fi
    echo "Overwriting existing key..."
fi

echo "Generating new SSH key ($SSH_KEY_PATH)..."
# -t ed25519: modern, secure key type
# -f: output filename
# -N "": no passphrase for automation (use with caution!)
# -C: comment for the key
ssh-keygen -t ed25519 -f "$SSH_KEY_PATH" -N "" -C "$KEY_COMMENT" -q

if [ $? -eq 0 ]; then
    echo "SSH key generated successfully."
    chmod 600 "$SSH_KEY_PATH" # Ensure private key permissions are secure
else
    echo "Error: Failed to generate SSH key."
    exit 1
fi

# --- 4. Add SSH Key to ssh-agent (Optional, but good practice for usage) ---
# Ensure ssh-agent is running
if ! pgrep -x "ssh-agent" > /dev/null; then
    echo "Starting ssh-agent..."
    eval "$(ssh-agent -s)"
else
    echo "ssh-agent is already running."
fi

echo "Adding SSH key to ssh-agent..."
ssh-add "$SSH_KEY_PATH" &> /dev/null # Suppress output if successful

if [ $? -eq 0 ]; then
    echo "SSH key added to ssh-agent."
else
    echo "Warning: Failed to add SSH key to ssh-agent. You may need to add it manually."
fi


# --- 5. Add Public Key to GitHub (Idempotent) ---
echo "Checking for existing SSH key on GitHub titled '$KEY_TITLE'..."
# Get the fingerprint of the key with the matching title
FINGERPRINT_TO_DELETE=$(gh ssh-key list | grep "$KEY_TITLE" | awk '{print $4}' || true)

if [ -n "$FINGERPRINT_TO_DELETE" ]; then
    echo "Key found on GitHub. Deleting it to ensure a clean state..."
    gh ssh-key delete "$FINGERPRINT_TO_DELETE" --yes
fi

echo "Adding new public key to GitHub..."
gh ssh-key add "$SSH_KEY_PUB_PATH" --title "$KEY_TITLE"

if [ $? -eq 0 ]; then
    echo "Public SSH key successfully added to GitHub with title: '$KEY_TITLE'"
    echo "You should now be able to use this key for GitHub authentication."
else
    echo "Error: Failed to add public SSH key to GitHub."
    echo "Please check your GitHub CLI authentication and permissions."
    exit 1
fi

echo "--- GitHub SSH Key Automation Completed ---"
echo "Public key file: $SSH_KEY_PUB_PATH"
echo "Private key file: $SSH_KEY_PATH"

# --- 6. Switch dotfiles repo remote URL to SSH ---
# The bootstrap process clones via HTTPS, this step switches it to SSH.
DOTFILES_DIR_CHECK="${DOTFILES_DIR_CHECK:-$HOME/.dotfiles}" # Use env var or default
if [ -d "$DOTFILES_DIR_CHECK" ] && [ -d "$DOTFILES_DIR_CHECK/.git" ]; then
    echo "Switching origin remote URL to SSH for dotfiles repository..."
    (cd "$DOTFILES_DIR_CHECK" && git remote set-url origin "git@github.com:yordycg/dotfiles-2024.git")
    echo "Dotfiles repository remote URL updated."
else
    echo "Warning: Dotfiles directory not found at '$DOTFILES_DIR_CHECK'. Skipping remote URL update."
fi
