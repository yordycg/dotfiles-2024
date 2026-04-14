###############################################################################
# GIT UTILS
###############################################################################

# Clonar un repositorio y entrar directamente
function gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Parsear rama actual de git (útil para prompts personalizados)
function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
