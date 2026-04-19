# 🚀 Dotfiles - Plan de Mejoras y Tareas Pendientes

Este documento sirve como guía para las próximas optimizaciones y funcionalidades de este repositorio de configuraciones.

## 🔴 PRIORIDAD 1: Cimientos y Velocidad (Impacto Inmediato)
- [x] **Centralización de Variables de Entorno**:
    - Mover todos los `export` de `.zshrc`, scripts y configs a un único archivo `shell/exports.sh`.
    - Asegurar que todos los scripts (como el de tmux) lean de ese archivo central para evitar rutas duplicadas.
- [x] **Profiling del Shell**: Implementar `zprof` (Zsh) o `fish --profile` para identificar y eliminar retardos en la apertura de la terminal.
- [x] **Configuración de Node con `fnm`**: Crear script para instalar la última versión LTS, activarla y establecerla como default.
- [x] **Lazy Loading de Herramientas**: Configurar la carga diferida para `nvm`, `pyenv`, `sdkman` o similares, evitando que ralenticen cada nueva terminal.
- [x] **Ajuste de Sensibilidad del Trackpad**: Investigar y reducir la velocidad de scroll (es demasiado rápida). 
    - [x] Ajustado `scroll_factor = 0.5` en `hyprland.conf`.
    - [x] Ajustado `mouse-scroll-multiplier = 1` en `Ghostty`.
- [ ] **Docker "The Professional Way" (Arch Linux)**:
    - Instalación de `docker`, `docker-compose` y `lazydocker`.
    - Configuración del grupo `docker` para ejecución sin `sudo`.
    - Habilitar y optimizar el demonio mediante `systemd`.


## 🟡 PRIORIDAD 2: Flujo de Trabajo (Multiplicador de Productividad)
- [x] **Gestor de Proyectos con fzf**: 
    - [x] Implementada función `work` (ex `tat`) para sesiones automáticas.
    - [x] Implementada función `jump` para navegar entre repos y universidad.
- [ ] **Búsqueda de Historial con `Atuin`**:
    - Reemplazar el historial por defecto con `Atuin` (SQLite) para búsquedas ultra-rápidas y sincronizadas.
- [x] **Configuración Global de LSP/Linters**: Centralizar archivos como `.clang-format`, `.prettierrc` o configs de `ruff` en un lugar común para asegurar consistencia en todos los editores.
- [x] **Optimización de Tmux**: 
    - [x] **Persistencia**: Instalar y configurar `tmux-resurrect` y `tmux-continuum` para que las sesiones sobrevivan a reinicios.
    - [x] **Navegación Fuzzy**: Integrado con `jump` y `sessionx`.
    - [x] **Estética**: Diseñar una `status-line` minimalista que armonice con los colores de Hyprland y Waybar.
    - [x] **Mantenimiento**: Evaluar un script de limpieza periódica para sesiones inactivas (Opción B del workflow).
    - [x] **Sesión Core**: Autogenerar la sesión `dotfiles` al inicio.
    - [ ] **Navegación Instantánea con `zoxide`**:
        - Sustituir `z` por `zoxide` e integrarlo con `fzf` y `tmux` para saltar a cualquier directorio desde un popup global.
    - [ ] **Workflow de Git Avanzado**:
        - Implementar `git-delta` para diffs con resaltado de sintaxis profesional.
        - Crear funciones para `git worktree` para trabajar en múltiples ramas simultáneamente sin cambiar de contexto.

## 🔵 PRIORIDAD 3: UX y Documentación (Fricción Cognitiva)
- [x] **Visor de Keymaps unificado (`keys`)**:
    - [x] Extraer Aliases de `shell/aliases.sh`.
    - [x] Extraer atajos de `tmux.conf`.
    - [x] Extraer binds de `hyprland.conf`.
    - [ ] **Pendiente**: Extraer atajos de Neovim (investigar parseo de Lua).
- [x] **Cheatsheet interactivo**: Implementado buscador con `fzf` y sincronizado con cambios recientes.
- [ ] **Investigación y Benchmarking**:
    - [ ] **ZenNotes**: Evaluar como alternativa ligera de notas (https://zennotes.org).
    - [ ] **OpenClaw**: Investigar utilidad e integración en el flujo de trabajo.
    - [ ] **Análisis de Dotfiles Externos**: Estudiar repositorios de referencia (ej: https://dotfiles.substtack.com) para extraer trucos y optimizaciones de rendimiento.

## 🟢 PRIORIDAD 4: Mantenimiento y Estética (Pulido Final)
- [ ] **Gestión Profesional de Dotfiles (`Chezmoi`)**:
    - Evaluar migrar los scripts de symlinks manuales a `chezmoi` para soportar plantillas (ej. diferentes correos de git según el host).
- [ ] **Script de Instalación y Sync para Zed**:
    - Crear script para instalar el editor Zed y vincular automáticamente `settings.json` y `keymap.json`.
- [ ] **Unificación de Temas (Single Source of Truth)**: 
    - Investigar un sistema para cambiar el tema globalmente (ej. de Nord a Catppuccin) en todos los componentes: Hyprland, Ghostty, Waybar, Tmux y Neovim, usando un único archivo de configuración o script.
- [ ] **Sincronización de Paquetes**:
    - Realizar auditoría periódica de apps instaladas (`pacman` y `yay`).
    - Actualizar listas en `os/linux/post-install-arch/packages/pkglist-official.txt` y `pkglist-aur.txt`.
    - Crear un script `pkg-sync` que automatice la exportación de estas listas.
- [ ] **Gestión de Wallpapers**: 
    - Integrar un selector de wallpapers (ej. usando `swww` o `hyprpaper` con `fzf` o `rofi/tofi`).
    - Organizar la carpeta `~/workspace/repos/wallpapers`.
- [ ] **Consolidación Total de Neovim**: 
    - Migrar a una única configuración modular basada en `Lazy.nvim` (Lua).
    - **Stack a evaluar/comparar**:
        - `LSP`: Nativo con `blink.cmp` (autocompletado de alto rendimiento).
        - `Formatting/Linting`: `conform.nvim` y `nvim-lint`.
        - `Fuzzy Finder`: `fzf-lua` o `fff.nvim`.
        - `File Browser`: `oil.nvim` (edición de archivos como buffers).
        - `UI/UX`: `fidget.nvim` (progreso LSP), `gitsigns.nvim`, `glance.nvim` (previsualización de código).
- [ ] **Pantalla de Inicio (Login Manager) - Estética Pro**:
    - Instalar y configurar `SDDM` como gestor de arranque.
    - Implementar un tema basado en QML/CSS para eliminar el aspecto básico.
    - **Recomendaciones**: `sddm-sugar-candy-git`, `sddm-theme-catppuccin` o un tema minimalista que soporte avatares circulares y fondos desenfocados.
    - Sincronizar el fondo de pantalla del login con el de Hyprland automáticamente.

