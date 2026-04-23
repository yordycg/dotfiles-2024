#!/bin/bash
# install/install-harlequin.sh

set -e

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando instalación automatizada de Harlequin (Universal SQL TUI)...${NC}"

# 1. Verificar si estamos en Arch Linux
if ! [ -f /etc/arch-release ]; then
    echo -e "${YELLOW}⚠️ Este script está optimizado para Arch Linux. Continuando con precaución...${NC}"
fi

# 2. Instalar dependencias base con pacman
echo -e "${BLUE}📦 Instalando dependencias base (pipx, unixodbc)...${NC}"
sudo pacman -S --needed --noconfirm python-pipx unixodbc

# 3. Configurar pipx
echo -e "${BLUE}⚙️ Configurando pipx...${NC}"
pipx ensurepath --force
export PATH="$HOME/.local/bin:$PATH" # Asegurar PATH en esta sesión de script

# 4. Instalar Driver ODBC para SQL Server (AUR)
if ! odbcinst -q -d -n "ODBC Driver 18 for SQL Server" &> /dev/null; then
    echo -e "${BLUE}🔌 Instalando Microsoft ODBC Driver para SQL Server...${NC}"
    if command -v yay &> /dev/null; then
        yay -S --noconfirm msodbcsql18
    elif command -v paru &> /dev/null; then
        paru -S --noconfirm msodbcsql18
    else
        echo -e "${YELLOW}⚠️ No se encontró yay o paru. Por favor, instala 'msodbcsql18' manualmente desde el AUR.${NC}"
    fi
else
    echo -e "${GREEN}✅ Driver ODBC de SQL Server ya instalado.${NC}"
fi

# 5. Instalar Harlequin
echo -e "${BLUE}📦 Instalando Harlequin via pipx...${NC}"
if ! command -v harlequin &> /dev/null; then
    pipx install harlequin
else
    echo -e "${GREEN}✅ Harlequin ya está instalado. Actualizando...${NC}"
    pipx upgrade harlequin
fi

# 6. Inyectar adaptadores
echo -e "${BLUE}🔌 Configurando adaptadores (Postgres, MySQL, ODBC)...${NC}"
pipx inject harlequin harlequin-postgres --include-deps || true
pipx inject harlequin harlequin-mysql --include-deps || true
pipx inject harlequin harlequin-odbc --include-deps || true

echo -e "${GREEN}✨ ¡Todo listo!${NC}"
echo -e "💡 Usa ${YELLOW}hq${NC} para empezar."
echo -e "🔔 Si el comando 'hq' no funciona de inmediato, ejecuta: ${YELLOW}source ~/.zshrc${NC}"
