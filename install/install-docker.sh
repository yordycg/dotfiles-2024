#!/usr/bin/env bash

# --- [docker] Professional Installation Script for Arch Linux ---
# This script installs Docker, Docker Compose, and LazyDocker,
# sets up user permissions, and optimizes systemd services.

set -e # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Starting Docker "The Professional Way" Installation...${NC}"

# 1. Install Packages
echo -e "${BLUE}==> Installing docker, docker-compose and lazydocker...${NC}"
if command -v pacman >/dev/null; then
    sudo pacman -S --noconfirm --needed docker docker-compose lazydocker
else
    echo "Error: This script is intended for Arch Linux (pacman not found)."
    exit 1
fi

# 2. Setup User Group (No sudo workflow)
echo -e "${BLUE}==> Configuring docker group...${NC}"
if ! getent group docker >/dev/null; then
    sudo groupadd docker
fi

echo -e "${BLUE}==> Adding $USER to docker group...${NC}"
sudo usermod -aG docker "$USER"

# 3. Optimize Systemd Services
# We enable the socket instead of the service for "on-demand" startup
echo -e "${BLUE}==> Enabling docker.socket (Socket Activation)...${NC}"
sudo systemctl enable --now docker.socket
sudo systemctl disable docker.service # Ensure the full service doesn't start on boot

# 4. Final verification
echo -e "${GREEN}==> Docker installation complete!${NC}"
echo -e "${GREEN}==> IMPORTANT: You need to RE-LOG or run 'newgrp docker' to apply group changes.${NC}"
echo -e "${BLUE}==> Tip: Use 'ld' (lazydocker) to manage your containers visually.${NC}"
