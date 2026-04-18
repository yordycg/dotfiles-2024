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

# Navegación (Usa 'z carpeta' para saltos rápidos)
alias ..="cd .." # [sys] Subir un nivel
alias ...="cd ../.." # [sys] Subir dos niveles

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

# Git + FZF (Acciones en bloque)
alias gafzf='git ls-file -m -o --exclude-standard | fzf -m | xargs git add' # [git] Seleccionar archivos para añadir
alias gbfzf='git branch | fzf | xargs git checkout' # [git] Cambiar de rama con búsqueda

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
alias va="source .venv/bin/activate" # [py] Activar entorno virtual
alias pmr="python manage.py runserver" # [py] Django: Arrancar servidor
alias pmm="python manage.py migrate" # [py] Django: Ejecutar migraciones

# WSL & Paths específicos
alias win="cd /mnt/c/Users/Yordy" # [os] Ir al Home de Windows
alias dev="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/" # [os] Carpeta principal de estudios
alias dircpp="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/02\ Cpp/" # [os] Carpeta de C++
