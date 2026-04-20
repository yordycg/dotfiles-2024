#   KEYMAP DE COMANDOS Y ATAJOS
# Prefix Tmux: CTRL + SPACE
# Prefix Hyprland: SUPER (Windows Key)

# [SYS] SYSTEM & NAVIGATION
[sys] c                  | Limpiar la terminal (clear)
[sys] x                  | Cerrar la sesión actual (exit)
[sys] ~                  | Ir a la carpeta personal (home)
[sys] dot                | Ir a la carpeta de configuración (dotfiles)
[sys] repos              | Ir a la carpeta de proyectos/repositorios
[sys] shutdown           | Apagar el equipo inmediatamente (sudo shutdown now)
[sys] restart            | Reiniciar el equipo (sudo reboot)
[sys] mv                 | Mover archivos pidiendo confirmación (mv -i)
[sys] ..                 | Subir un nivel (cd ..)
[sys] ...                | Subir dos niveles (cd ../..)
[sys] z <dir>            | Salto rápido a directorio (Zoxide)
[sys] zi                 | Salto rápido interactivo con FZF (Zoxide)
[sys] ls                 | Ver todo con iconos y detalles de Git (eza)
[sys] ll                 | Ver lista detallada con iconos (eza)
[sys] lt                 | Ver estructura de carpetas en árbol (eza)
[sys] mkcd <dir>         | Crear y entrar a un directorio (función)
[sys] up <n>             | Subir N niveles en el árbol de directorios (función)
[sys] win                | Ir al Home de Windows (/mnt/c/Users/Yordy)

# [UTIL] SEARCH & UTILS
[util] grep              | Buscar texto con colores (--color=auto)
[util] f <text>          | Buscar archivos simple (find . | grep)
[util] h <text>          | Buscar en el historial de comandos (history | grep)
[util] cat <file>        | Ver archivos con resaltado (bat)
[util] copy < file       | Copiar contenido al portapapeles (wl-copy)
[util] paste             | Pegar contenido desde el portapapeles (wl-paste)
[util] ff                | Información del sistema (fastfetch)
[util] wifi              | Gestionar Wi-Fi (nmtui)
[util] findd <text>      | Buscar archivos en el Home (ls ~/ | grep)
[util] extract <file>    | Extractor universal (.zip, .tar, .7z, etc)
[util] cleanup           | Limpiar archivos temporales (__pycache__, node_modules, etc)
[util] pkg-sync          | Sincronizar listas de paquetes instalados (Arch)
[util] findedit <text>   | Buscar con ripgrep y abrir en línea exacta en Vim
[util] cpz <file>        | Copiar a destino inteligente (Zoxide + FD + FZF)
[util] mvz <file>        | Mover a destino inteligente (Zoxide + FD + FZF)

# [GIT] GIT & GITHUB
[git] lg                 | Abrir LazyGit (TUI)
[git] g                  | Git base
[git] gs                 | Estado rápido (git status)
[git] ga <file>          | Añadir archivo específico al stage
[git] gaa                | Añadir TODO al stage (git add -A)
[git] gc                 | Confirmar cambios (abre editor)
[git] gp                 | Subir cambios al servidor (push)
[git] gl                 | Bajar cambios del servidor (pull)
[git] gf                 | Actualizar ramas y limpiar borradas (fetch --all -p)
[git] gpp                | Sincronizar rápido (pull && push)
[git] gafzf              | Añadir archivos interactivo (con preview de diff)
[git] gbfzf              | Cambiar rama interactivo (con preview de log)
[git] glfzf              | Buscar commit y copiar hash (con preview de diff)
[git] gsfzf              | Ver y aplicar stash (con preview)
[git] ghr                | Gestionar repositorios (GitHub CLI - gh repo)
[git] ghpr               | Gestionar Pull Requests (GitHub CLI - gh pr)
[git] ghi                | Gestionar Issues (GitHub CLI - gh issue)
[git] gclone <url>       | Clonar y entrar directamente al directorio (función)

# [CONF] CONFIG FILES & EDITORS
[conf] v                 | Abrir Neovim
[conf] v.                | Abrir Neovim en la carpeta actual
[conf] eal               | Editar archivo de aliases
[conf] edot              | Abrir carpeta de dotfiles en Neovim
[conf] szsh              | Recargar configuración de ZSH
[conf] keys              | Abrir este buscador de atajos interactivo

# [DOCKER] DOCKER & CONTAINERS
[docker] d               | Docker base
[docker] dc              | Docker Compose base
[docker] ld              | LazyDocker (TUI)

# [TMUX] TMUX & SESSIONS (Prefix: CTRL + Space)
[tmux] t                 | Tmux base
[tmux] tl                | Listar sesiones activas de Tmux
[tmux] tks               | Matar servidor Tmux
[tmux] tkss <name>       | Matar sesión específica de Tmux
[tmux] work <name>       | Iniciar/Atachar sesión basada en carpeta actual (función)
[tmux] jump              | Selector rápido de sesiones (Popup FZF nativo)
[tmux] tcl               | Limpieza interactiva de sesiones con preview (FZF)
[tmux] tmux-sessions     | Seleccionar sesión con FZF (Popup)
[tmux] tmux-windows      | Seleccionar ventana con FZF (Popup)
[tmux] Prefix + r        | Renombrar la ventana actual
[tmux] Prefix + R        | Recargar configuración de Tmux
[tmux] Prefix + c        | Crear nueva ventana (pestaña) en el path actual
[tmux] Prefix + Space    | Alternar entre las dos últimas ventanas
[tmux] Prefix + b        | Alternar entre las dos últimas sesiones
[tmux] Prefix + X        | Matar ventana específica (pide ID)
[tmux] Prefix + s        | Dividir panel horizontalmente (Split)
[tmux] Prefix + v        | Dividir panel verticalmente (Vertical)
[tmux] Prefix + h/j/k/l  | Moverse entre paneles (Vim Style)
[tmux] Prefix + C-H/J/K/L| Redimensionar paneles (+5 celdas)
[tmux] Prefix + z        | Maximizar el panel actual (Zoom)
[tmux] Prefix + H        | Ventana Anterior (Mayúscula + H)
[tmux] Prefix + L        | Ventana Siguiente (Mayúscula + L)
[tmux] Prefix + o        | BUSCADOR DE SESIONES (SessionX + Zoxide + FZF)
[tmux] Prefix + F        | Lanzar comandos de Tmux con FZF (Tmux-FZF)
[tmux] Prefix + u        | Abrir URLs detectadas en la terminal (FZF-URL)
[tmux] Prefix + I        | Instalar plugins (TPM)
[tmux] Prefix + U        | Actualizar plugins (TPM)
[tmux] Prefix + Alt + u  | Limpiar plugins no listados (TPM)
[tmux] Prefix + Ctrl-s   | GUARDAR Sesión actual (Tmux-Resurrect)
[tmux] Prefix + Ctrl-r   | RESTAURAR última sesión (Tmux-Resurrect)
[tmux] Alt + g           | Abrir LazyGit (Popup)
[tmux] Alt + y           | Abrir Yazi (Popup)
[tmux] Alt + s           | Abrir Terminal de notas/scratch (Popup)
[tmux] Alt + n           | Abrir nueva ventana rápido (en path actual)
[tmux] Modo Copia: v     | Iniciar selección (Modo vi)
[tmux] Modo Copia: y     | Copiar selección (Modo vi)

# [HYPR] HYPRLAND (Prefix: SUPER/WIN)
[hypr] SUPER + T         | Abrir la terminal (Ghostty)
[hypr] SUPER + B         | Abrir el navegador (Thorium)
[hypr] SUPER + O         | Abrir notas (Obsidian)
[hypr] SUPER + C         | Abrir editor de código (VS Code)
[hypr] SUPER + S         | Abrir editor alternativo (Ghostty + Neovim)
[hypr] SUPER + Q         | Cerrar la ventana enfocada
[hypr] SUPER + M         | Salir de Hyprland (Logout)
[hypr] SUPER + F         | Abrir gestor de archivos (Thunar)
[hypr] SUPER + W         | Cambiar ventana entre flotante o mosaico
[hypr] SUPER + A         | Abrir menú de aplicaciones (Tofi)
[hypr] SUPER + J         | Cambiar división (horizontal/vertical)
[hypr] SUPER + N         | Abrir/Cerrar panel de notificaciones (SwayNC)
[hypr] SUPER + E         | Abrir selector de Emojis (Smile)
[hypr] SUPER + V         | Historial del Portapapeles (Cliphist + Tofi)
[hypr] SUPER + P         | Selector de Color (Hyprpicker)
[hypr] SUPER + L         | Bloquear pantalla (Hyprlock)
[hypr] SUPER + ESC       | Menú de apagado (Wlogout)
[hypr] CTRL + ESC        | Activar/Desactivar Waybar (toggle)
[hypr] Print             | Captura pantalla completa (Grimblast)
[hypr] SUPER + Print     | Captura ventana activa (Grimblast)
[hypr] SUPER + ALT + Prt | Captura área seleccionada (Grimblast)
[hypr] SUPER + Flechas   | Mover el foco entre ventanas
[hypr] SUPER + SHIFT + Fl| Mover ventana de posición
[hypr] SUPER + CTRL + Fl | Redimensionar ventana activa
[hypr] SUPER + [1-0]     | Ir al escritorio 1-10
[hypr] SUPER + SHIFT+[1-0]| Mover ventana al escritorio 1-10
[hypr] SUPER + SHIFT + S | Mover ventana al escritorio especial (Magic)
[hypr] SUPER + Scroll    | Navegar entre escritorios
[hypr] SUPER + Z         | Mover ventana con el mouse
[hypr] SUPER + X         | Redimensionar ventana con el mouse
[hypr] Vol Up/Down/Mute  | Control de audio (Pamixer)
[hypr] Bright Up/Down    | Control de brillo (Brightnessctl)

# [DEV] LANGUAGES & DEVELOPMENT
[node] pn                | PNPM base
[node] pnrd              | Arrancar entorno de desarrollo (pnpm run dev)
[node] fnm               | Gestor de versiones de Node (Lazy Loaded)
[py] py                  | Python 3 base
[py] venv                | Crear entorno virtual (.venv)
[py] .venv (auto)        | ACTIVACIÓN AUTOMÁTICA al entrar en la carpeta
[py] va                  | Activar entorno virtual manual
[py] vd                  | Desactivar entorno virtual
[py] pyclean             | Limpieza de caché (__pycache__, etc)
[py] pi                  | Instalar paquete (pip install)
[py] pir                 | Instalar desde requirements.txt
[py] pif                 | Guardar dependencias actuales (pip freeze)
[py] djs                 | Iniciar proyecto Django (config .)
[py] pma <name>          | Crear nueva aplicación Django (startapp)
[py] pm                  | Comando base de Django (manage.py)
[py] pmr                 | Django: Arrancar servidor
[py] pmm                 | Django: Ejecutar migraciones
[py] pmmm                | Django: Crear nuevas migraciones
[py] pms                 | Django: Shell interactiva pro (shell_plus)
[py] pmc                 | Django: Crear superusuario
[py] pmt                 | Django: Ejecutar tests
[py] pmcs                | Django: Recolectar estáticos (collectstatic)
[py] rf                  | Linter Ruff (con auto-fix)
[py] rff                 | Formateador Ruff
[py] pt                  | Suite de tests Pytest
[cpp] rcc <path>         | Compilar y ejecutar C/C++ (Makefile/CMake/Single)
[cpp] bproj <name>       | Crear proyecto básico C o C++ (función)
[cpp] cleanc             | Limpiar binarios compilados (find + delete)

# [NVIM] NEVIM KEYMAPS (General)
[nvim] :Lazy             | Gestionar plugins
[nvim] :Mason            | Gestionar LSPs y Formatters
[nvim] <space>ff         | Buscar archivos (Telescope)
[nvim] <space>fg         | Buscar texto en archivos (Live Grep)
[nvim] <space>e          | Abrir explorador de archivos (Oil/NvimTree)
