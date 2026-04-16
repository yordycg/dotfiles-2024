# 🚀 Dotfiles - Plan de Mejoras y Tareas Pendientes

Este documento sirve como guía para las próximas optimizaciones y funcionalidades de este repositorio de configuraciones.

## 🔴 PRIORIDAD 1: Cimientos y Velocidad (Impacto Inmediato)
- [x] **Centralización de Variables de Entorno**:
    - Mover todos los `export` de `.zshrc`, scripts y configs a un único archivo `shell/exports.sh`.
    - Asegurar que todos los scripts (como el de tmux) lean de ese archivo central para evitar rutas duplicadas.
- [ ] **Profiling del Shell**: Implementar `zprof` (Zsh) o `fish --profile` para identificar y eliminar retardos en la apertura de la terminal.
- [ ] **Lazy Loading de Herramientas**: Configurar la carga diferida para `nvm`, `pyenv`, `sdkman` o similares, evitando que ralenticen cada nueva terminal.

## 🟡 PRIORIDAD 2: Flujo de Trabajo (Multiplicador de Productividad)
- [ ] **Gestor de Proyectos con fzf**: Crear un script (ej. `pj` o `work`) que permita buscar repositorios en `~/workspace/repos/`, abrir una sesión de Tmux nombrada y lanzar el editor (NVIM/Zed) automáticamente.
- [ ] **Configuración Global de LSP/Linters**: Centralizar archivos como `.clang-format`, `.prettierrc` o configs de `ruff` en un lugar común para asegurar consistencia en todos los editores.
- [ ] **Optimización de Tmux**: 
    - Revisar si la "Opción B" (sesiones independientes) necesita un script de limpieza periódica de sesiones antiguas.

## 🔵 PRIORIDAD 3: UX y Documentación (Fricción Cognitiva)
- [ ] **Visor de Keymaps unificado**: Crear un alias o script (ej. `keys`) que extraiga y muestre los atajos de:
    - `hyprland.conf` (buscando `bind =`)
    - `tmux.conf` (buscando `bind-key` o `bind`)
    - `nvim` (si es posible extraerlos de la config)
- [ ] **Cheatsheet interactivo**: Evaluar el uso de `cheat.sh` o un script simple con `fzf` para buscar comandos rápidos.
- [ ] **Hyprland: Indicador de Workspace Activo**: 
    - Modificar `waybar/style.css` para que el workspace actual tenga un color distinto (clase `#workspaces button.active` o `#workspaces button.focused`).

## 🟢 PRIORIDAD 4: Mantenimiento y Estética (Pulido Final)
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
- [ ] **Sheldon**: 
    - Mantener el formato individual de plugins para evitar errores de plantillas en el futuro.
