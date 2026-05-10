#!/bin/bash
# ----------------------------------------------------------------------
# Arch Linux Services Configuration
# ----------------------------------------------------------------------

set -e

log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; exit 1; }

log_info "Configurando servicios del sistema..."

# 1. Docker (Configuracion Profesional)
if command -v docker >/dev/null; then
    log_info "Configurando Docker..."
    # Crear grupo si no existe
    if ! getent group docker >/dev/null; then
        sudo groupadd docker
    fi
    # Añadir usuario al grupo
    sudo usermod -aG docker "$USER"
    
    # Activar por socket (on-demand) para ahorrar recursos
    sudo systemctl enable --now docker.socket
    sudo systemctl disable docker.service >/dev/null 2>&1 || true
    log_info "Docker configurado (Socket Activation habilitado)."
fi

# 2. SDDM (Solo si no es modo Minimal)
if [ "$MINIMAL" != "true" ] && command -v sddm >/dev/null; then
    log_info "Enabling sddm.service..."
    sudo systemctl enable sddm.service || log_info "Advertencia: No se pudo habilitar sddm."
fi

# 3. NetworkManager (Solo Bare Metal)
if [ "$MINIMAL" != "true" ] && command -v NetworkManager >/dev/null; then
    log_info "Enabling NetworkManager..."
    sudo systemctl enable NetworkManager.service
fi

# 4. Bluetooth (Solo Bare Metal)
if [ "$MINIMAL" != "true" ] && command -v bluetoothctl >/dev/null; then
    log_info "Enabling bluetooth.service..."
    sudo systemctl enable bluetooth.service
fi

log_info "Configuracion de servicios completada."
