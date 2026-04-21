###############################################################################
# SYSTEM & NAVIGATION # [sys]
###############################################################################
alias c="clear" # [sys] Limpiar la terminal
alias x="exit" # [sys] Cerrar la sesión actual
alias ~="cd ~" # [sys] Ir a la carpeta personal (home)
alias dot="cd $DOTFILES" # [sys] Ir a la carpeta de configuración (dotfiles)
alias repos="cd $REPOS_PATH" # [sys] Ir a la carpeta de proyectos/repositorios
alias shutdown="sudo shutdown now" # [sys] Apagar el equipo inmediatamente
alias restart="sudo reboot" # [sys] Reiniciar el equipo
alias mv="mv -i" # [sys] Mover archivos pidiendo confirmación

# Search & Navigation
# --- [z] Navigation (Zoxide) ---
# Initialization is handled in zshrc/config.fish
alias zi="zi" # [z] Zoxide interactive (fzf)

# Eza (Modern ls)
alias ls="eza -al --icons=always --color=always --group-directories-first --git" # [sys] Ver todo con iconos y detalles de Git
alias ll="eza -l --icons=always --color=always --group-directories-first --git" # [sys] Ver lista detallada con iconos
alias lt="eza -aT --icons=always --color=always --group-directories-first" # [sys] Ver estructura de carpetas en árbol

###############################################################################
# SEARCH & UTILS # [util]
###############################################################################
alias grep="grep --color=auto" # [util] Buscar texto con colores
alias f="find . | grep " # [util] Buscar archivos (simple)
alias h="history | grep " # [util] Buscar en el historial de comandos
alias cat="bat" # [util] Ver archivos con resaltado (bat)
alias copy="wl-copy" # [util] Copiar al portapapeles (Wayland)
alias paste="wl-paste" # [util] Pegar desde el portapapeles (Wayland)
alias ff="fastfetch" # [util] Info del sistema
alias wifi="nmtui" # [util] Gestionar Wi-Fi

# Funciones rápidas
findd() { ls ~/ | grep "$1"; } # [util] Buscar en Home

###############################################################################
# EDITORS & CONFIG # [conf]
###############################################################################
alias v="nvim" # [conf] Neovim (El estándar pro)
alias v.="nvim ." # [conf] Abrir Neovim en la carpeta actual
alias eal="v $DOTFILES/shell/aliases.sh" # [conf] Editar estos alias
alias edot="cd $DOTFILES && v ." # [conf] Abrir todos tus dotfiles en Neovim
alias theme="bash $DOTFILES/os/linux/scripts/theme-picker.sh" # [sys] Selector de temas interactivo (fzf)
alias set-theme="bash $DOTFILES/os/linux/scripts/set-theme.sh" # [sys] Aplicar tema directamente
alias szsh="source ~/.zshrc && echo 'ZSH Reloaded!'" # [conf] Recargar configuración de ZSH

###############################################################################
# GIT & GITHUB # [git]
###############################################################################
# Herramientas visuales
alias lg="lazygit" # [git] Abrir LazyGit (Panel de control Pro)

# Comandos esenciales (Para todo lo demás usa Alt+g)
alias g="git" # [git] Git base
alias gs="git status" # [git] Estado rápido
alias ga="git add" # [git] Añadir archivo específico
alias gaa="git add -A" # [git] Añadir TODO al stage
alias gc="git commit" # [git] Confirmar cambios (abre editor)
alias gp="git push" # [git] Subir cambios al servidor
alias gl="git pull" # [git] Bajar cambios del servidor
alias gf="git fetch --all -p" # [git] Actualizar ramas y limpiar borradas
alias gpp="git pull && git push" # [git] Sincronizar rápido

# Git + FZF (Acciones visuales interactivas)
alias gafzf='gafzf' # [git] Seleccionar archivos para añadir (con preview de diff)
alias gbfzf='gbfzf' # [git] Cambiar de rama (con preview de log)
alias glfzf='glfzf' # [git] Buscar commit y copiar hash (con preview de diff)
alias gsfzf='gsfzf' # [git] Ver stash antes de aplicar

# GitHub CLI (Lo esencial)
alias ghr='gh repo' # [git] Gestionar repositorios
alias ghpr='gh pr' # [git] Gestionar Pull Requests
alias ghi='gh issue' # [git] Gestionar Issues

###############################################################################
# INFRASTRUCTURE (DOCKER & TMUX) # [infra]
###############################################################################
# Docker (Para gestión total usa 'ld')
alias d="docker" # [docker] Docker base
alias dc="docker-compose" # [docker] Docker Compose
alias ld="lazydocker" # [docker] LazyDocker (Panel de control Pro)

# Tmux
alias t="tmux" # [tmux] Tmux base
alias tl="tmux ls" # [tmux] Listar sesiones activas
alias tks="tmux kill-server" # [tmux] Matar servidor Tmux
alias tkss="tmux kill-session -t" # [tmux] Matar sesión específica

###############################################################################
# LANGUAGES & DEV # [dev]
###############################################################################
# Node.js
alias pn="pnpm" # [node]
alias pnrd="pnpm run dev" # [node] Arrancar entorno de desarrollo

# Python & Django
alias py="python3" # [py]
alias venv="python3 -m venv .venv" # [py] Crear entorno virtual
alias va="source .venv/bin/activate" # [py] Activar entorno virtual (opcional con auto-activación)
alias vd="deactivate" # [py] Desactivar entorno virtual
alias pyclean="find . -type d -name '__pycache__' -exec rm -rf {} + && find . -type d -name '*_cache' -exec rm -rf {} +" # [py] Limpieza de caché

# UV (Modern Package Management - Commented for learning phase)
# alias uv="uv" # [py] UV base
# alias uva="uv add" # [py] UV add package
# alias uvr="uv run" # [py] UV run command
# alias uvs="uv sync" # [py] UV sync environment
# alias uvi="uv init" # [py] UV initialize project

# Pip / Package Management
alias pi="pip install" # [py] Instalar paquete
alias pir="pip install -r requirements.txt" # [py] Instalar dependencias desde archivo
alias pif="pip freeze > requirements.txt" # [py] Guardar dependencias actuales

# Django Management
alias djs="django-admin startproject config ." # [dj] Iniciar proyecto (estilo Pro)
alias pma="python manage.py startapp" # [dj] Crear nueva aplicación
alias pm="python manage.py" # [dj] Comando base de Django
alias pmr="python manage.py runserver" # [dj] Django: Arrancar servidor
alias pmm="python manage.py migrate" # [dj] Django: Ejecutar migraciones
alias pmmm="python manage.py makemigrations" # [dj] Django: Crear nuevas migraciones
alias pms="python manage.py shell_plus" # [dj] Django: Shell interactiva mejorada
alias pmc="python manage.py createsuperuser" # [dj] Django: Crear superusuario
alias pmt="python manage.py test" # [dj] Django: Ejecutar tests
alias pmcs="python manage.py collectstatic" # [dj] Django: Recolectar archivos estáticos

# Quality Tools (Linter & Tests)
alias rf="ruff check --fix" # [py] Linter con auto-fix
alias rff="ruff format" # [py] Formateador de código
alias pt="pytest" # [py] Suite de tests profesional

# WSL & Paths específicos
alias win="cd /mnt/c/Users/Yordy" # [os] Ir al Home de Windows
alias dev="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/" # [os] Carpeta principal de estudios
alias dircpp="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/02\ Cpp/" # [os] Carpeta de C++
alias wall='bash /home/yordycg/workspace/repos/dotfiles-2024/scripts/wallpaper-picker.sh'
