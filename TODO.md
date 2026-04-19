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


## 🟡 PRIORIDAD 2: Flujo de Trabajo (Multiplicador de Productividad)
- [x] **Gestor de Proyectos con fzf**: 
    - [x] Implementada función `work` (ex `tat`) para sesiones automáticas.
    - [x] Implementada función `jump` para navegar entre repos y universidad.
- [x] **Configuración Global de LSP/Linters**: Centralizar archivos como `.clang-format`, `.prettierrc` o configs de `ruff` en un lugar común para asegurar consistencia en todos los editores.
- [x] **Optimización de Tmux**: 
    - [x] **Persistencia**: Instalar y configurar `tmux-resurrect` y `tmux-continuum` para que las sesiones sobrevivan a reinicios.
    - [x] **Navegación Fuzzy**: Integrado con `jump` y `sessionx`.
    - [x] **Estética**: Diseñar una `status-line` minimalista que armonice con los colores de Hyprland y Waybar.
    - [x] **Mantenimiento**: Evaluar un script de limpieza periódica para sesiones inactivas (Opción B del workflow).
    - [x] **Sesión Core**: Autogenerar la sesión `dotfiles` al inicio.

## 🔵 PRIORIDAD 3: UX y Documentación (Fricción Cognitiva)
- [x] **Visor de Keymaps unificado (`keys`)**:
    - [x] Extraer Aliases de `shell/aliases.sh`.
    - [x] Extraer atajos de `tmux.conf`.
    - [x] Extraer binds de `hyprland.conf`.
    - [ ] **Pendiente**: Extraer atajos de Neovim (investigar parseo de Lua).
- [ ] **Cheatsheet interactivo**: Evaluar el uso de `cheat.sh` o un script simple con `fzf` para buscar comandos rápidos.
- [ ] **Hyprland: Indicador de Workspace Activo**: 
    - Modificar `waybar/style.css` para que el workspace actual tenga un color distinto (clase `#workspaces button.active` o `#workspaces button.focused`).

## 🟢 PRIORIDAD 4: Mantenimiento y Estética (Pulido Final)
- [ ] **Unificación de Temas (Single Source of Truth)**: 
    - Investigar un sistema para cambiar el tema globalmente (ej. de Nord a Catppuccin) en todos los componentes: Hyprland, Ghostty, Waybar, Tmux y Neovim, usando un único archivo de configuración o script.
- [ ] **Sincronización de Paquetes**:
    - Realizar auditoría periódica de apps instaladas (`pacman` y `yay`).
    - Actualizar listas en `os/linux/post-install-arch/packages/pkglist-official.txt` y `pkglist-aur.txt`.
    - Crear un script `pkg-sync` que automatice la exportación de estas listas.
- [ ] **Gestión de Wallpapers**: 
    - Integrar un selector de wallpapers (ej. usando `swww` o `hyprpaper` con `fzf` o `rofi/tofi`).
    - Organizar la carpeta `~/workspace/repos/wallpapers`.
- [ ] **Pantalla de Inicio (Login Manager)**:
    - Investigar y mejorar el arranque. ¿Usar `SDDM` con un tema moderno, `Ly` (TUI) o `Greetd`?
    - Personalizar el Splash Screen (Plymouth) si se desea una estética Arch más pulida.
- [ ] **Limpieza de Scripts de Instalación**:
    - Unificar `bootstrap.sh` y `setup-workspace.sh` para que sigan la nueva estructura de `workspace/repos/`.
- [ ] **Limpieza de Neovim**: Consolidar las múltiples configuraciones de Neovim en una sola definitiva.
- [ ] **Sheldon**: 
    - Mantener el formato individual de plugins para evitar errores de plantillas en el futuro.
