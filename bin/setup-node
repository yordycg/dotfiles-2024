#!/bin/bash

# =============================================================================
# Setup Node.js with fnm
# =============================================================================

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# 1. Check if fnm is installed
if ! command -v fnm &> /dev/null; then
    log_info "fnm not found. Please ensure it is installed via your package manager (e.g., yay -S fnm)."
    exit 1
fi

# 2. Initialize fnm for this session
log_info "Initializing fnm..."
eval "$(fnm env --use-on-cd)"

# 3. Install Node.js LTS
log_info "Installing Node.js LTS..."
fnm install --lts

# 4. Set LTS as default
log_info "Setting Node.js LTS as default..."
fnm default $(fnm list | grep 'lts' | awk '{print $2}' | head -n 1) || fnm default lts-latest

# 5. Verify installation
NODE_VERSION=$(node -v)
log_success "Node.js $NODE_VERSION installed and set as default."

# 6. Install global packages (Optional but recommended)
log_info "Installing basic global packages..."
npm install -g neovim tree-sitter-cli

log_success "Node.js environment setup complete!"
