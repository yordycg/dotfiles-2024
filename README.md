# Dotfiles 2024 - Yordy Carmona

Mi ecosistema de desarrollo personal, optimizado para Arch Linux (Hyprland/Zsh) y Windows (PowerShell/Scoop). Diseñado para la velocidad, la estética minimalista y la automatización total.

## Instalación Rápida (Bootstrap)

Si acabas de formatear tu equipo, usa estos comandos para configurar TODO automáticamente:

### Arch Linux
```bash
curl -sSL https://raw.githubusercontent.com/yordycg/dotfiles-2024/main/install.sh | bash
```

### Windows (PowerShell Administrador)
```powershell
irm https://raw.githubusercontent.com/yordycg/dotfiles-2024/main/install-windows.ps1 | iex
```

---

## Qué incluye este ecosistema

- Window Manager: Hyprland (Linux) con estética minimalista.
- Shell: Zsh con zoxide, fzf, eza y starship.
- Editor: Neovim (configuración modular en Lua nvim-yc-26) y Zed.
- Terminal: Ghostty / Kitty / WezTerm.
- Herramientas Git: ggi (generador de .gitignore), gafzf, gcc (Conventional Commits).
- Entorno Dev: Docker orquestado, Python con auto-venv, Node.js y más.

---

## Estructura del Proyecto

- install.sh: Instalador maestro para Linux.
- install-windows.ps1: Instalador maestro para Windows.
- os/: Configuraciones específicas de sistema (Linux/Windows/Cross-platform).
- editors/: Configuraciones de Neovim, Zed y VS Code.
- shell/: Alias, funciones y configuraciones de Zsh/Fish.
- git/: Configuraciones globales de Git y plantillas.
- scripts/: Utilidades de soporte (symlinks, pickers, etc.).

---

## Mantenimiento y Actualización

Si ya tienes el repositorio clonado y quieres aplicar cambios recientes o refrescar los enlaces simbólicos, simplemente ejecuta el instalador desde la carpeta raíz:

**En Linux:**
```bash
./install.sh
```

**En Windows:**
```powershell
./install-windows.ps1
```

## Notas de Post-Instalación
- Fuentes: Se recomienda usar una Nerd Font (ej: JetBrainsMono Nerd Font) para que los iconos se vean correctamente.
- SSH: Asegúrate de configurar tus llaves SSH para poder sincronizar repositorios privados.
