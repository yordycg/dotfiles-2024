#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to display messages (re-defined for modularity or can be sourced)
log_info() {
    echo -e "\033[0;32m[INFO]\033[0m $1"
}

log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
    exit 1
}

log_info "Configuring systemd services..."

# Example: Enable SDDM display manager
# Check if sddm is installed before trying to enable it
if command -v sddm &> /dev/null; then
    log_info "Enabling sddm.service..."
    sudo systemctl enable sddm.service || log_error "Failed to enable sddm.service."
else
    log_info "sddm not found. Skipping sddm.service enablement."
fi

# Add other service configurations here as needed
# For example:
# log_info "Enabling some_other_service.service..."
# sudo systemctl enable some_other_service.service || log_error "Failed to enable some_other_service.service."

log_info "Systemd services configuration complete."
