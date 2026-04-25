# 🚀 Dotfiles - Plan de Mejoras y Tareas Pendientes

Este documento sirve como guía para las próximas optimizaciones y funcionalidades de este repositorio de configuraciones.

## 🔴 PRIORIDAD 1: Cimientos y Velocidad (Impacto Inmediato)
- [x] **Reparar Historial de Zsh**: Corregir error `zsh: corrupt history file /home/yordycg/.zsh_history`. (Reparado usando strings y backup creado).
- [x] **Centralización de Variables de Entorno**:
    - Mover todos los `export` de `.zshrc`, scripts y configs a un único archivo `shell/exports.sh`.
    - Asegurar que todos los scripts (como el de tmux) lean de ese archivo central para evitar rutas duplicadas.
- [x] **Profiling del Shell**: Implementar `zprof` (Zsh) o `fish --profile` para identificar y eliminar retardos en la apertura de la terminal.
- [x] **Configuración de Node con `fnm`**: Crear script para instalar la última versión LTS, activarla y establecerla como default.
- [x] **Lazy Loading de Herramientas**: Configurar la carga diferida para `nvm`, `pyenv`, `sdkman` o similares, evitando que ralenticen cada nueva terminal.
- [x] **Ajuste de Sensibilidad del Trackpad**: Investigar y reducir la velocidad de scroll (es demasiado rápida). 
    - [x] Ajustado `scroll_factor = 0.5` en `hyprland.conf`.
    - [x] Ajustado `mouse-scroll-multiplier = 1` en `Ghostty`.
- [x] **Docker "The Professional Way" (Arch Linux)**:
    - [x] Instalación de `docker`, `docker-compose` y `lazydocker`.
    - [x] Configuración del grupo `docker` para ejecución sin `sudo`.
    - [x] Habilitar y optimizar el demonio mediante `systemd` (Socket Activation).
    - [x] Script de automatización creado en `install/install-docker.sh`.


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
    - [x] **Navegación Instantánea con `zoxide`**:
        - Sustituir `z` por `zoxide` e integrarlo con `fzf` y `tmux` para saltar a cualquier directorio desde un popup global.
    - [x] **Workflow de Git Avanzado**:
        - [x] Implementar `git-delta` para diffs con resaltado de sintaxis profesional.
        - [x] Implementar funciones interactivas con FZF (`gafzf`, `gbfzf`, `glfzf`, `gsfzf`) con previsualización.
- [x] **Acciones rápidas en Neovim**: Crear función/keymap para seleccionar todo el texto de un archivo y copiarlo al portapapeles.

- [x] **Ecosistema Python & Django Pro**:
    - [x] **Expandir alias**: Mapear comandos de `django-admin` y `manage.py` (`djs`, `pma`, `pmcs`).
    - [x] **Calidad de Código**: Integrar alias para `ruff` y `pytest`.
    - [x] **Limpieza**: Añadido alias `pyclean` para mantenimiento de caché.
    - [x] **Automatización de Entornos**: Crear función para detección y activación automática de `.venv` al entrar en un directorio.
- [x] **Mejorar `cpz` / `mvz` para Rutas Desconocidas**:
    - [x] Investigar y aplicar búsqueda profunda con `fd` dinámico dentro de FZF.
    - [x] Optimizar `_smart_path_picker` con colores diferenciales y soporte de argumentos iniciales.
    - [x] Mejorar visualización de rutas largas mediante `sed` y `awk` (home as ~).
- [x] **Documentar Persistencia de Tmux**:
    - [x] Agregar `Prefix + Ctrl-s` (Guardar) y `Prefix + Ctrl-r` (Restaurar) al `cheatsheet.md`.
    - [x] Verificar que `tmux-resurrect` y `tmux-continuum` funcionen correctamente en el arranque.

## 🔵 PRIORIDAD 3: UX y Documentación (Fricción Cognitiva)
- [x] **Visor de Keymaps unificado (`keys`)**:
    - [x] Extraer Aliases de `shell/aliases.sh`.
    - [x] Extraer atajos de `tmux.conf`.
    - [x] Extraer binds de `hyprland.conf`.
    - [ ] **Pendiente**: Extraer atajos de Neovim (investigar parseo de Lua).
- [x] **Cheatsheet interactivo**: Implementado buscador con `fzf` y sincronizado con cambios recientes.
- [ ] **Estandarización de Interfaz FZF**:
    - Definir 1 o 2 layouts máximos (preferiblemente tipo popup) para todas las herramientas que usan `fzf` (scripts propios, plugins de zsh/fish, etc.).
- [ ] **Experiencia VS Code en Neovim**: Investigar y configurar plugins para cerrar la brecha de UX:
    - [ ] **Symbols Outline**: Panel lateral con la estructura de clases/funciones (ej: `symbols-outline.nvim` o `aerial.nvim`).
    - [ ] **Breadcrumbs**: Barra de navegación superior con símbolos LSP (ej: `barbecue.nvim` o `lspsaga.nvim`).
    - [ ] **Mini-map**: Vista previa del código a la derecha (ej: `codewindow.nvim`).
    - [ ] **Multi-cursor**: Soporte para edición en múltiples líneas (ej: `iron-nvim` o `multiple-cursors.nvim`).
- [ ] **Investigación y Benchmarking**:
    - [ ] **ZenNotes**: Evaluar como alternativa ligera de notas (https://zennotes.org).
    - [ ] **OpenClaw**: Investigar utilidad e integración en el flujo de trabajo.
    - [ ] **Análisis de Dotfiles Externos**: Estudiar repositorios de referencia (ej: https://dotfiles.substtack.com) para extraer trucos y optimizaciones de rendimiento.

## 🟢 PRIORIDAD 4: Mantenimiento y Estética (Pulido Final)
- [x] **Estética de Terminal**:
    - [x] Agregar `fastfetch` al iniciar la terminal.
    - [ ] **Selector de Fuentes**: Crear script que use `fzf` para previsualizar y cambiar la fuente de la terminal dinámicamente.
- [ ] **Gestión Profesional de Dotfiles (`Chezmoi`)**:
    - Evaluar migrar los scripts de symlinks manuales a `chezmoi` para soportar plantillas (ej. diferentes correos de git según el host).
- [ ] **Script de Instalación y Sync para Zed**:
    - Crear script para instalar el editor Zed y vincular automáticamente `settings.json` y `keymap.json`.
- [x] **Unificación de Temas (Single Source of Truth)**: 
    - [x] Investigar un sistema para cambiar el tema globalmente (ej. de Nord a Catppuccin) en todos los componentes: Hyprland, Ghostty, Waybar, Tmux y Neovim, usando un único archivo de configuración o script.
- [x] **Ghostty - Problema de Hot Reload en Temas**:
    - Investigar por qué Ghostty no aplica los cambios de configuración del tema global de forma dinámica. (Solucionado: usando SIGUSR2 para forzar la recarga).
- [ ] **Aura Theme - Solucionar integración en Neovim**:
    - Verificar que el plugin `daltonmenezes/aura-theme` cargue correctamente. Al ser un monorepo, es posible que Neovim necesite que se añada `packages/neovim` al `runtimepath` manualmente o mediante una configuración específica en el gestor de plugins.
- [ ] **Sincronización de Paquetes**:
    - Realizar auditoría periódica de apps instaladas (`pacman` y `yay`).
    - Actualizar listas en `os/linux/post-install-arch/packages/pkglist-official.txt` y `pkglist-aur.txt`.
    - Crear un script `pkg-sync` que automatice la exportación de estas listas.
- [x] **Gestión de Wallpapers**: 
    - [x] Integrar un selector de wallpapers interactivas con `swww` y `fzf`.
    - [x] Implementar persistencia del fondo de pantalla entre reinicios.
    - [x] Organizar la carpeta `~/workspace/repos/wallpapers`.

- [x] **Consolidación Total de Neovim**: 
    - [x] **Actualizar Symlink**: Apuntar el symlink de `nvim` a la nueva configuración `nvim-yc-26`.
    - [x] **Explorador de Archivos (Neo-tree)**: Implementada barra lateral tipo VS Code para mejorar la visibilidad y gestión de archivos.
    - [x] **Oil.nvim**: Configurado como herramienta secundaria para edición masiva de archivos.
    - [ ] **Organización de Autocommands**:
        - [ ] Crear directorio/archivo específico para `autocmds` (limpiar `init.lua`).
        - [ ] Investigar y migrar automatizaciones útiles de otras configs (`kickstart`, `lazyvim`, `nvchad`).
    - [ ] **Glance.nvim**: Investigar utilidad del plugin para previsualizar definiciones y referencias sin saltar de archivo.
    - [ ] **Transparencia**: Reparar y mejorar el plugin/config de transparencia (actualmente no se aplica correctamente).
    - Migrar a una única configuración modular basada en `Lazy.nvim` (Lua).
    - **Stack a evaluar/comparar**:
        - `LSP`: Nativo con `blink.cmp` (autocompletado de alto rendimiento).
        - `Formatting/Linting`: `conform.nvim` y `nvim-lint`.
        - `Fuzzy Finder`: `fzf-lua` o `fff.nvim`.
        - `File Browser`: `oil.nvim` (edición de archivos como buffers).
        - `UI/UX`: `fidget.nvim` (progreso LSP), `gitsigns.nvim`, `glance.nvim` (previsualización de código).
- [x] **Pantalla de Inicio (Login Manager) - Estética Pro**:
    - [x] Instalar y configurar `SDDM` con el tema `sugar-candy`.
    - [x] Sincronización automática del fondo de pantalla entre Hyprland y SDDM.
    - [x] Configuración de avatares circulares y estética minimalista.

- [ ] **Limpieza de Scripts de Instalación (Entry Points)**:
    - Unificar todos los scripts de la raíz (`bootstrap.sh`, `install.sh`, etc.) en solo dos maestros: `install-linux.sh` e `install-windows.ps1`.
- [ ] **Actualización de Temas de Carpetas e Iconos**:
    - Investigar y aplicar un tema de iconos consistente (ej: Catppuccin Papirus, Tela-circle) que se refleje en Thunar, Waybar y el Shell (`eza`).
- [ ] **Sheldon**: 
    - Mantener el formato individual de plugins para evitar errores de plantillas en el futuro.

## 🐳 PRIORIDAD 5: Ecosistema Docker & Bases de Datos (Workflow Pro)
- [x] **Evolución del Orquestador `db-up`**:
    - [x] **Detección Inteligente**: Modificado a comando `db` con aislamiento por proyecto.
    - [x] **Healthchecks**: Implementada lógica de limpieza y estados.
- [x] **Abstracción de Harlequin (TUI)**:
    - [x] **Scripts Wrapper**: Creado comando `hq` con detección automática de .env.
    - [x] **Aliases Dinámicos**: Implementada detección por puertos e integración con FZF.
    - [x] **Estandarización de Temas**: Sincronizado con el sistema global de temas.
- [x] **Orquestación de DBs con Docker**:
    - [x] Creado comando `db up <type>` con contenedores aislados por carpeta.
    - [x] Soporte para MySQL, PostgreSQL y SQL Server.
- [x] **Gestión de DBs desde la Terminal**:
    - [x] **Neovim (Dadbod)**: Configurado Dadbod UI con carga automática de .env.
    - [x] **Autocompletado**: Integrado con Blink.cmp para sugerencias en SQL.
    - [x] **Generador de .env**: Creado comando `gen-env` para inicializar proyectos rápidamente.
