# 🚀 Dotfiles - Plan de Mejoras y Tareas Pendientes

Este documento sirve como guía para las próximas optimizaciones y funcionalidades de este repositorio de configuraciones.

## 🔴 PRIORIDAD 1: Cimientos y Velocidad (Impacto Inmediato)
- [ ] **Resiliencia en Pacman (WSL)**: Automatizar `pacman-key --init`, `--populate archlinux` y la actualizacion de `archlinux-keyring` antes de cualquier instalacion para evitar fallos de firmas o errores 404 en imagenes base antiguas.
- [ ] **Seguridad de Propiedad (Ownership)**: Mejorar los scripts (`install.sh` e `install-windows.ps1`) para detectar y advertir si el repositorio fue clonado como `sudo` o `Administrator`, evitando errores de "dubious ownership" y problemas de permisos en symlinks.
- [ ] **SSH Idempotente y Unico**: Mejorar `bin/git-gen-ssh` para generar nombres de llave mas especificos (ej. incluyendo timestamp/date) y asegurar que siempre se suba una llave valida aunque existan nombres similares en GitHub.
- [ ] **Estructura Senior de Scripts (Arch Linux)**: Mejorar la arquitectura de los scripts de instalacion y configuracion de Arch Linux bajo una perspectiva Senior (modularidad, manejo de errores robusto, logs avanzados y abstraccion de entorno).
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
- [x] **Búsqueda de Historial con `Atuin`**:
    - Reemplazar el historial por defecto con `Atuin` (SQLite) para búsquedas ultra-rápidas y sincronizadas.
- [x] **Configuración Global de LSP/Linters**: Centralizar archivos como `.clang-format`, `.prettierrc` o configs de `ruff` en un lugar común para asegurar consistencia en todos los editores.
- [x] **Optimización de Tmux**: 
    - [x] **Persistencia**: Instalar y configurar `tmux-resurrect` y `tmux-continuum` para que las sesiones sobrevivan a reinicios.
    - [x] **Navegación Fuzzy**: Integrado con `jump` y `sessionx`.
    - [x] **Estética**: Diseñar una `status-line` minimalista que armonice con los colores de Hyprland y Waybar.
    - [x] **Mantenimiento**: Evaluar un script de limpieza periódica para sesiones inactivas (Opción B del workflow).
    - [x] **Sesión Core**: Autogenerar la sesión `dotfiles` al inicio.
    - [x] **Corrección de Sesiones Duplicadas**: Eliminar la redundancia entre las sesiones `dotfiles` y `dotfiles-2024` al iniciar el sistema (actualmente se generan ambas y son idénticas).
    - [x] **Navegación Instantánea con `zoxide`**:
        - Sustituir `z` por `zoxide` e integrarlo con `fzf` y `tmux` para saltar a cualquier directorio desde un popup global.
    - [x] **Workflow de Git Avanzado**:
        - [x] Implementar `git-delta` para diffs con resaltado de sintaxis profesional.
        - [x] Implementar funciones interactivas con FZF (`gafzf`, `gbfzf`, `glfzf`, `gsfzf`) con previsualización.
        - [x] **Conventional Commits**: Investigar e implementar una herramienta (`commitizen`, `cocogitto` o `commitlint`) para estandarizar los mensajes de commit y automatizar changelogs. (Implementado comando `gcc` con FZF).
        - [x] **Optimización de Fixup con `gfix`**:
            - Crea una función de Bash llamada `gfix` que facilite el flujo de `git commit --fixup`.
            - 1. Mostrar una lista interactiva de los últimos 20 commits usando `fzf`.
            - 2. Al seleccionar un commit, crear automáticamente un commit de fixup para los archivos que ya están en el stage.
            - 3. Ejecutar inmediatamente un rebase interactivo con `--autosquash` de forma no interactiva (usando `GIT_EDITOR=true`) tomando como base el padre del commit seleccionado para que el proceso sea instantáneo.
            - Si no hay cambios en el stage, debe avisar al usuario.
        - [x] **Alias de Log Personalizado (`gl`)**:
            - Crear un alias o función (ej. `gl`) para un `git log` visual y compacto.
            - Debe soportar el paso de argumentos para limitar la cantidad de commits (ej. `gl -3`).
            - Formato sugerido (basado en `glfzf`): `%C(auto)%h %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)`.
            - Incluir `--graph` y `--decorate` para una mejor visualización de ramas.
- [x] **Gestión Profesional de Gitignore**:
    - [x] **Gitignore Global**: Creado `git/.gitignore_global` para ignorar basura de OS y editores (Neovim, VS Code, logs).
    - [x] **Comando `ggi`**: Generador interactivo con FZF y la API de gitignore.io para proyectos modulares.
    - [x] **Utilidad `gi_add`**: Función helper para añadir reglas de forma segura y sin duplicados desde otros scripts.
    - [x] **Refactorización**: Integrado en `gen-env` (proyectos) y `venv` (python) para una protección automática y limpia.
- [ ] **Scaffolding Profesional y Plantillas de Proyectos**:
    - [ ] **Investigación**: Evaluar herramientas de plantillas alternativas compatibles con Windows como `copier` o `degit`.
- [x] **Acciones rápidas en Neovim**: Crear función/keymap para seleccionar todo el texto de un archivo y copiarlo al portapapeles.

- [x] **Ecosistema Python & Django Pro**:
- [x] **Expandir alias**: Mapear comandos de `django-admin` y `manage.py` (`djs`, `pma`, `pmcs`).
- [x] **Calidad de Código**: Integrar alias para `ruff` y `pytest`.
- [x] **Limpieza**: Añadido alias `pyclean` para mantenimiento de caché.
- [x] **Automatización de Entornos**: Crear función para detección y activación automática de `.venv` al entrar en un directorio.
- [x] **Mejora del Script de Creación de Venv**: Asegurar que el script que genera el entorno `.venv` también lo active automáticamente en la sesión actual tras su creación.

- [x] **Mejorar `cpz` / `mvz` para Rutas Desconocidas**:
    - [x] Investigar y aplicar búsqueda profunda con `fd` dinámico dentro de FZF.
    - [x] Optimizar `_smart_path_picker` con colores diferenciales y soporte de argumentos iniciales.
    - [x] Mejorar visualización de rutas largas mediante `sed` y `awk` (home as ~).
- [x] **Documentar Persistencia de Tmux**:
- [x] Agregar `Prefix + Ctrl-s` (Guardar) y `Prefix + Ctrl-r` (Restaurar) al `cheatsheet.md`.
- [x] Verificar que `tmux-resurrect` y `tmux-continuum` funcionen correctamente en el arranque.
- [ ] **Nuevas Mejoras de Tmux (Inspiración Felipe Coury)**:
- [ ] **Edit Scrollback en Neovim**: Implementar `Prefix + e` para capturar el buffer del panel y abrirlo en Neovim para búsqueda y edición.
- [ ] **Smart Clear (`Alt + k`)**: Atajo para limpiar terminal y scrollback simultáneamente.
- [ ] **Sincronización de Títulos**: Configurar actualización dinámica del título de la ventana (Ghostty/Wezterm) basado en el proceso actual.
## 🔵 PRIORIDAD 3: UX y Documentación (Fricción Cognitiva)
- [x] **Visor de Keymaps unificado (`keys`)**:
    - [x] Extraer Aliases de `shell/aliases.sh`.
    - [x] Extraer atajos de `tmux.conf`.
    - [x] Extraer binds de `hyprland.conf`.
    - [ ] **Pendiente**: Extraer atajos de Neovim (investigar parseo de Lua).
- [x] **Cheatsheet interactivo**: Implementado buscador con `fzf` y sincronizado con cambios recientes.
- [x] **Visualización de Markdown**:
    - [x] Instalado `glow` para visualización en terminal (alias `md`).
    - [x] Configurado `render-markdown.nvim` en Neovim para renderizado en buffer.
- [x] **Estandarización de Interfaz FZF**:
    - [x] Definido un layout único y moderno en `FZF_DEFAULT_OPTS` con bordes redondeados y colores consistentes.
    - [x] Limpiados scripts individuales eliminando parámetros visuales redundantes.
- [x] **Expansión del Ecosistema FZF**:
    - [x] Implementadas integraciones interactivas para gestión del sistema:
        - `fkill`: Selector de procesos para matar.
        - `fsvc`: Gestor de servicios `systemctl` (start/stop/status).
        - `fenv`: Inspector de variables de entorno con copia al portapapeles.
        - Búsqueda de archivos en Neovim (fzf-lua ya configurado).
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
    - [x] **Selector de Fuentes**: Crear script `font-picker` que use `fzf` para previsualizar y cambiar la fuente (y tamaño con `font-size`) dinámicamente en Ghostty, Kitty y Alacritty.- [ ] **Gestión Profesional de Dotfiles (`Chezmoi`)**:
    - Evaluar migrar los scripts de symlinks manuales a `chezmoi` para soportar plantillas (ej. diferentes correos de git según el host).
- [x] **Script de Instalación y Sync para Zed**:
    - [x] Crear script para instalar el editor Zed y vincular automáticamente `settings.json` y `keymap.json`.
- [x] **Unificación de Temas (Single Source of Truth)**: 
    - [x] Investigar un sistema para cambiar el tema globalmente (ej. de Nord a Catppuccin) en todos los componentes: Hyprland, Ghostty, Waybar, Tmux y Neovim, usando un único archivo de configuración o script.
- [x] **Ghostty - Problema de Hot Reload en Temas**:
    - Investigar por qué Ghostty no aplica los cambios de configuración del tema global de forma dinámica. (Solucionado: usando SIGUSR2 para forzar la recarga).
- [ ] **Aura Theme - Solucionar integración en Neovim**:
    - Verificar que el plugin `daltonmenezes/aura-theme` cargue correctamente. Al ser un monorepo, es posible que Neovim necesite que se añada `packages/neovim` al `runtimepath` manualmente o mediante una configuración específica en el gestor de plugins.
- [x] **Sincronización de Paquetes**:
    - [x] Realizar auditoría periódica de apps instaladas (`pacman` y `yay`).
    - [x] Actualizar listas en `os/linux/post-install-arch/packages/pkglist-official.txt` y `pkglist-aur.txt`.
    - [x] Crear un script `pkg-sync` que automatice la exportación de estas listas.

- [x] **Gestión de Wallpapers**: 
    - [x] Integrar un selector de wallpapers interactivas con `swww` y `fzf`.
    - [x] Implementar persistencia del fondo de pantalla entre reinicios.
    - [x] Organizar la carpeta `~/workspace/infra/wallpapers`.

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

- [x] **Limpieza y Organización de Scripts**:
    - [x] Crear directorio `bin/` para scripts independientes.
    - [x] Mover scripts de `os/linux/scripts/` y `scripts/` a `bin/`.
    - [x] Renombrar scripts eliminando la extensión `.sh` para uso como comandos nativos.
    - [x] Actualizar `$PATH` en `shell/exports.sh` para incluir `bin/`.
- [x] **Limpieza de Scripts de Instalación (Entry Points)**:
    - [x] Unificar todos los scripts de la raíz (`bootstrap.sh`, `install.sh`, etc.) en solo dos maestros: `install.sh` (Linux) e `install-windows.ps1`.

- [ ] **Actualización de Temas de Carpetas e Iconos**:
    - Investigar y aplicar un tema de iconos consistente (ej: Catppuccin Papirus, Tela-circle) que se refleje en Thunar, Waybar y el Shell (`eza`).
- [ ] **Sheldon**: 
    - Mantener el formato individual de plugins para evitar errores de plantillas en el futuro.

## 🐳 PRIORIDAD 5: Ecosistema Docker & Bases de Datos (Workflow Pro)
- [x] **Evolución del Orquestador `db-docker`**:
    - [x] **Detección Inteligente**: Modificado a comando `db-docker` con aislamiento por proyecto.
    - [x] **Healthchecks**: Implementada lógica de limpieza y estados.
- [x] **Abstracción de Harlequin (TUI)**:
    - [x] **Scripts Wrapper**: Creado comando `hq` con detección automática de .env.
    - [x] **Aliases Dinámicos**: Implementada detección por puertos e integración con FZF.
    - [x] **Estandarización de Temas**: Sincronizado con el sistema global de temas.
- [x] **Orquestación de DBs con Docker**:
    - [x] Creado comando `db-docker up <type>` con contenedores aislados por carpeta.
    - [x] Soporte para MySQL, PostgreSQL y SQL Server.
- [x] **Gestión de DBs desde la Terminal**:
    - [x] **Neovim (Dadbod)**: Configurado Dadbod UI con carga automática de .env.
    - [x] **Autocompletado**: Integrado con Blink.cmp para sugerencias en SQL.
    - [x] **Generador de .env**: Creado comando `gen-env` para inicializar proyectos rápidamente.
- [x] **Estandarización y Automatización de `.env`**:
    - [x] **Investigación**: Estudiar estándares profesionales (e.g., `direnv` para carga automática, `doppler` para gestión de secretos) y adoptar las mejores prácticas.
    - [x] **Mejorar `gen-env`**: 
        - [x] Crear automáticamente un archivo `.env.example` sincronizado (mismas llaves, valores vacíos).
        - [x] Crear un script/función de sincronización que detecte nuevas variables en el `.env` local y las añada al `.env.example` para mantenerlo al día sin exponer credenciales.
        - [x] Permitir que `gen-env` extraiga variables de otros contextos del proyecto (no solo DB).

## 🚀 PRÓXIMAS FRONTERAS (Investigación Senior)
- [x] **Orquestación de Tareas con `Just`**:
    - [x] Implementar un `Justfile` global para unificar comandos de mantenimiento de dotfiles.
    - [x] Adoptar `Just` en proyectos personales para eliminar la carga cognitiva de recordar stacks.
- [ ] **Gestión Profesional de Dotfiles (`Chezmoi`)**:
    - [ ] Migrar de symlinks manuales a `Chezmoi` para soportar plantillas (Linux vs Windows).
    - [ ] Gestionar archivos sensibles de forma segura.
- [ ] **Cheat-Sheets Dinámicos con `Navi`**:
    - [ ] Configurar `Navi` con `fzf` para documentar y ejecutar comandos complejos con variables.
- [ ] **Entornos de Desarrollo Aislados (`Devbox` / `Nix`)**:
    - [ ] Investigar el uso de entornos determinísticos para evitar "ensuciar" el sistema base con dependencias de proyectos.
- [ ] **Seguridad de Secretos (Zero-Trust)**:
    - [ ] Investigar integración de `Bitwarden/1Password CLI` con `direnv` para cargar secretos solo en memoria.

## 🪟 PRIORIDAD 6: Windows & PowerShell (Ecosistema Nativo)
- [x] **Optimización de PowerShell**:
    - [x] **Alias de Recarga**: Crear un alias (ej. `spw` o `sps`) para recargar el perfil de PowerShell (`. $PROFILE`).
    - [x] **Integración de Herramientas**: Asegurar que `zoxide`, `fzf` y `starship` estén correctamente configurados en el perfil global.
- [ ] **Refinar y Mejorar psmux en Windows**:
    - [ ] Investigar y corregir el bloqueo del popup al ejecutar `psmux-resurrect save` (`Prefix + Ctrl-s`).
    - [ ] Mejorar la estética de la barra de estado y la integración de plugins.
    - [ ] Evaluar estabilidad a largo plazo comparado con Windows Terminal nativo.
