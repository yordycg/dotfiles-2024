#   CHEATSHEET DE COMANDOS Y ATAJOS
# Prefix Tmux: CTRL + SPACE
# Prefix Hyprland: SUPER (Windows Key)

# [SYS] SYSTEM & NAVIGATION
[sys] c                  | Limpiar la terminal (clear)
[sys] x                  | Cerrar la sesión actual (exit)
[sys] ~                  | Ir a la carpeta personal (home)
[sys] dot                | Ir a la carpeta de configuración (dotfiles)
[sys] repos              | Ir a la carpeta de proyectos/repositorios
[sys] shutdown           | Apagar el equipo inmediatamente
[sys] restart            | Reiniciar el equipo
[sys] mv                 | Mover archivos pidiendo confirmación
[sys] ..                 | Subir un nivel (cd ..)
[sys] ...                | Subir dos niveles (cd ../..)
[sys] ls                 | Ver todo con iconos y detalles de Git (eza)
[sys] ll                 | Ver lista detallada con iconos (eza)
[sys] lt                 | Ver estructura de carpetas en árbol (eza)
[sys] mkcd <dir>         | Crear y entrar a un directorio (función)
[sys] up <n>             | Subir N niveles en el árbol de directorios

# [UTIL] SEARCH & UTILS
[util] grep              | Buscar texto con colores
[util] f <text>          | Buscar archivos (simple)
[util] h <text>          | Buscar en el historial de comandos
[util] cat <file>        | Ver archivos con resaltado (bat)
[util] ff                | Información del sistema (fastfetch)
[util] wifi              | Gestionar Wi-Fi (nmtui)
[util] findd <text>      | Buscar archivos en el Home
[util] extract <file>    | Extractor universal (.zip, .tar, .7z, etc)
[util] cleanup           | Limpiar archivos temporales (__pycache__, node_modules)
[util] pkg-sync          | Sincronizar listas de paquetes con dotfiles
[util] findedit <text>   | Buscar con ripgrep y abrir en línea exacta en Vim

# [GIT] GIT & GITHUB
[git] lg                 | Abrir LazyGit (TUI)
[git] g                  | Git base
[git] gs                 | Estado rápido (git status)
[git] ga <file>          | Añadir archivo específico al stage
[git] gaa                | Añadir TODO al stage
[git] gc                 | Confirmar cambios (abre editor)
[git] gp                 | Subir cambios al servidor (push)
[git] gl                 | Bajar cambios del servidor (pull)
[git] gf                 | Actualizar ramas y limpiar borradas (fetch)
[git] gpp                | Sincronizar rápido (pull && push)
[git] gafzf              | Seleccionar archivos para añadir con FZF
[git] gbfzf              | Cambiar de rama con búsqueda FZF
[git] ghr                | Gestionar repositorios (GitHub CLI)
[git] ghpr               | Gestionar Pull Requests (GitHub CLI)
[git] ghi                | Gestionar Issues (GitHub CLI)
[git] gclone <url>       | Clonar y entrar directamente al directorio

# [DOCKER] DOCKER & CONTAINERS
[docker] d               | Docker base
[docker] dc              | Docker Compose base
[docker] ld              | LazyDocker (TUI)

# [TMUX] TMUX & SESSIONS
[tmux] t                 | Tmux base
[tmux] tl                | Listar sesiones activas de Tmux
[tmux] tks               | Matar servidor Tmux
[tmux] tkss <name>       | Matar sesión específica de Tmux
[tmux] work <name>       | Iniciar/Atachar sesión basada en carpeta actual
[tmux] jump              | Selector rápido de sesiones (Popup FZF)
[tmux] tcl               | Limpieza interactiva de sesiones con preview
[tmux] tmux-sessions     | Seleccionar sesión con FZF
[tmux] tmux-windows      | Seleccionar ventana con FZF
[tmux] Prefix + r        | Renombrar la ventana actual
[tmux] Prefix + R        | Recargar configuración de Tmux
[tmux] Prefix + c        | Crear nueva ventana (pestaña)
[tmux] Prefix + Space    | Alternar entre las dos últimas ventanas
[tmux] Prefix + b        | Alternar entre las dos últimas sesiones
[tmux] Prefix + X        | Matar ventana específica (pide ID)
[tmux] Prefix + s        | Dividir panel horizontalmente (Split)
[tmux] Prefix + v        | Dividir panel verticalmente (Vertical)
[tmux] Prefix + h/j/k/l  | Moverse entre paneles (Vim Style)
[tmux] Prefix + C-h/j/k/l| Redimensionar paneles (Fino)
[tmux] Prefix + z        | Maximizar el panel actual (Zoom)
[tmux] Prefix + H/L      | Ventana Anterior / Siguiente
[tmux] Prefix + C-e      | Buscar y saltar entre sesiones (FZF Popup)
[tmux] Prefix + C-f      | Buscar y saltar entre ventanas (FZF Popup)
[tmux] Alt + g           | Abrir LazyGit (Popup)
[tmux] Alt + y           | Abrir Yazi (Popup)
[tmux] Alt + s           | Abrir Terminal de notas/scratch (Popup)
[tmux] Alt + n           | Abrir nueva ventana rápido
[tmux] Modo Copia: v     | Iniciar selección (Modo vi)
[tmux] Modo Copia: y     | Copiar selección (Modo vi)

# [HYPR] HYPRLAND (Prefix: SUPER/WIN)
[hypr] SUPER + T         | Abrir la terminal (Ghostty)
[hypr] SUPER + B         | Abrir el navegador (Thorium)
[hypr] SUPER + O         | Abrir notas (Obsidian)
[hypr] SUPER + C         | Abrir editor de código (VS Code)
[hypr] SUPER + S         | Abrir editor alternativo (Sublime)
[hypr] SUPER + Q         | Cerrar la ventana enfocada
[hypr] SUPER + M         | Salir de Hyprland (Logout)
[hypr] SUPER + F         | Abrir gestor de archivos (Nautilus)
[hypr] SUPER + W         | Cambiar ventana entre flotante o mosaico
[hypr] SUPER + A         | Abrir menú de aplicaciones (Tofi)
[hypr] SUPER + J         | Cambiar división (horizontal/vertical)
[hypr] SUPER + E         | Selector de Emojis y copiar al portapapeles
[hypr] SUPER + V         | Historial del Portapapeles (Cliphist)
[hypr] SUPER + P         | Selector de Color (Hyprpicker)
[hypr] SUPER + L         | Bloquear pantalla (Hyprlock)
[hypr] SUPER + ESC       | Menú de apagado (Wlogout)
[hypr] CTRL + ESC        | Activar/Desactivar Waybar
[hypr] Print             | Captura pantalla completa (Grimblast)
[hypr] SUPER + Print     | Captura ventana activa (Grimblast)
[hypr] SUPER + ALT + Prt | Captura área seleccionada (Grimblast)
[hypr] SUPER + Flechas   | Mover el foco entre ventanas
[hypr] SUPER+SHIFT+Arrib | Mover ventana de posición
[hypr] SUPER+CTRL+Arriba | Redimensionar ventana activa
[hypr] SUPER + [1-0]     | Ir al escritorio 1-10
[hypr] SUPER+SHIFT+[1-0] | Mover ventana al escritorio 1-10
[hypr] SUPER + SHIFT + S | Mover ventana al escritorio especial (Magic)
[hypr] SUPER + Scroll    | Navegar entre escritorios
[hypr] SUPER + Z / X     | Mover/Redimensionar con mouse
[hypr] Vol Up/Down/Mute  | Control de audio (Pamixer)
[hypr] Bright Up/Down    | Control de brillo (Brightnessctl)

# [NVIM] NEVIM KEYMAPS
[nvim] v                 | Abrir Neovim (v . para carpeta actual)
[nvim] :Lazy             | Gestionar plugins
[nvim] :Mason            | Gestionar LSPs y Formatters
[nvim] <space>ff         | Buscar archivos (Telescope)
[nvim] <space>fg         | Buscar texto en archivos (Live Grep)
[nvim] <space>e          | Abrir explorador de archivos (NvimTree/Oil)

# [DEV] LANGUAGES & DEVELOPMENT
[node] pn                | PNPM base
[node] pnrd              | Arrancar entorno de desarrollo (pnpm run dev)
[node] fnm               | Gestor de versiones de Node (Lazy Loaded)
[py] py                  | Python 3
[py] venv                | Crear entorno virtual (.venv)
[py] va                  | Activar entorno virtual
[py] pmr                 | Django: Arrancar servidor
[py] pmm                 | Django: Ejecutar migraciones
[cpp] rcc <path>         | Compilar y ejecutar C/C++ (Makefile/CMake/Single)
[cpp] bproj <name>       | Crear proyecto básico C o C++
[cpp] cleanc             | Limpiar binarios compilados

# [CONF] CONFIG FILES
[conf] eal               | Editar archivo de aliases
[conf] edot              | Abrir carpeta de dotfiles en Neovim
[conf] szsh              | Recargar configuración de ZSH
[conf] keys              | Abrir este buscador de atajos interactivo

# [OS] WSL & PATHS
[os] win                 | Ir al Home de Windows
[os] dev                 | Carpeta principal de Cursos/Programación
[os] dircpp              | Carpeta específica de C++
