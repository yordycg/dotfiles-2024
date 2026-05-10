#!/bin/bash
set -e

log_info() { echo -e "\033[0;32m[WSL-SETUP]\033[0m $1"; }

log_info "Configurando /etc/wsl.conf para Systemd, Automount y Red..."
sudo bash -c 'cat <<EOF > /etc/wsl.conf
[boot]
systemd=true

[automount]
enabled = true
options = "metadata"
mountFsTab = true

[network]
generateHosts = true
generateResolvConf = true

[interop]
enabled = true
appendWindowsPath = true
EOF'

log_info "Optimizando Pacman (Descargas paralelas)..."
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf || true

log_info "Configuración de WSL lista. (Recuerda ejecutar 'wsl --shutdown' al terminar todo)."
