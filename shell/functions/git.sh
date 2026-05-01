#!/usr/bin/env bash

# --- [git] Interactive Git Tools with FZF ---

# [git] Interactive Add (gafzf)
# View diffs before staging files. Multi-select with Tab.
function gafzf() {
    local files
    files=$(git ls-files -m -o --exclude-standard | fzf -m \
        --preview 'git diff --color=always {} | head -100' \
        --header "Tab to multi-select | Enter to add to stage" \
        --preview-window right:65%)
    if [[ -n "$files" ]]; then
        echo "$files" | xargs git add
        echo "Archivos añadidos al stage."
    fi
}

# [git] Interactive Branch Switch (gbfzf)
# View last commits of the branch before switching.
function gbfzf() {
    local branch
    branch=$(git branch --all | grep -v 'HEAD' | fzf --ansi --no-multi \
        --preview-window right:65% \
        --header "Enter to checkout branch" \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | sed "s/.* //" | sed "s#remotes/[^/]*/##")' \
        | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    if [[ -n "$branch" ]]; then
        git checkout "$branch"
    fi
}

# [git] Interactive Log (glfzf)
# Browse commits and see the full diff of each one. Enter to copy hash.
function glfzf() {
    local commit
    commit=$(git log --color=always --pretty=format:'%C(auto)%h %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)' | \
        fzf --ansi --no-multi --no-sort --preview-window right:65% \
        --preview 'git show --color=always $(echo {} | awk "{print \$1}")' \
        --header "Enter to copy hash to clipboard")
    if [[ -n "$commit" ]]; then
        local hash=$(echo "$commit" | awk '{print $1}')
        echo -n "$hash" | wl-copy
        echo "Hash $hash copiado al portapapeles."
    fi
}

# [git] Interactive Stash (gsfzf)
# See stash content before applying it.
function gsfzf() {
    local stash
    stash=$(git stash list | fzf --ansi --no-multi --preview-window right:65% \
        --preview 'git stash show -p --color=always $(echo {} | awk -F: "{print \$1}")' \
        --header "Enter to apply stash")
    if [[ -n "$stash" ]]; then
        local id=$(echo "$stash" | awk -F: '{print $1}')
        git stash apply "$id"
    fi
}

# [git] Conventional Commit (gcc)
# Estandariza mensajes de commit con tipo, verbo y descripción usando FZF.
function gcc() {
    # 0. Verificar si hay cambios en el stage
    if git diff --cached --quiet; then
        echo -e "\033[1;33m⚠️  No hay archivos en el stage area.\033[0m"
        echo -en "\033[1;34m📂 ¿Quieres añadir archivos con gafzf ahora? (y/n): \033[0m"
        read -r add_res
        if [[ "$add_res" == "y" ]]; then
            gafzf
            # Verificar de nuevo tras gafzf
            if git diff --cached --quiet; then
                echo -e "\033[1;31m❌ Sigue sin haber archivos en el stage. Abortando commit.\033[0m"
                return 1
            fi
        else
            echo -e "\033[1;31m❌ Abortando: Se requiere 'git add' antes de hacer commit.\033[0m"
            return 1
        fi
    fi

    # 1. Seleccionar Tipo
    local type
    type=$(echo -e "feat: Nuevas funcionalidades\nfix: Corrección de errores\ndocs: Documentación\nstyle: Estilo y formato\nrefactor: Refactorización de código\ntest: Pruebas\nchore: Tareas de mantenimiento\nbuild: Sistema de construcción o dependencias\nci: Configuración de CI" | \
        fzf --ansi --header "🚀 Select Commit Type" --height=40% --layout=reverse --border | cut -d: -f1)
    
    [[ -z "$type" ]] && return 0

    # 2. Definir verbos según el tipo
    local verbs=""
    case "$type" in
        feat)     verbs="add\nimplement\ncreate\nsetup\nintegrate" ;;
        fix)      verbs="fix\nresolve\nrepair\nhandle\ncorrect" ;;
        docs)     verbs="update\nadd\nimprove\ndocument" ;;
        style)    verbs="formatting\ncleanup\nrename\norganize" ;;
        refactor) verbs="simplify\noptimize\nrestructure\ndry" ;;
        test)     verbs="add\nupdate\nfix\nremove" ;;
        chore|build|ci) verbs="update\nbump\nclean\nconfig\nsetup" ;;
        *)        verbs="update" ;;
    esac

    # 3. Seleccionar Verbo
    local verb
    verb=$(echo -e "$verbs" | fzf --ansi --header "🔨 Select Verb/Action" --height=40% --layout=reverse --border)
    
    [[ -z "$verb" ]] && return 0

    # 4. Escribir descripción
    echo -en "\033[1;34m📝 Description for '$type: $verb ':\033[0m "
    read -r description
    
    [[ -z "$description" ]] && return 0

    # 5. Ejecutar Commit
    local full_message="$type: $verb $description"
    git commit -m "$full_message"
}

# [git] Smart Fixup (gfix)
# Facilitates the 'git commit --fixup' workflow.
# 1. Shows an interactive list of the last 20 commits.
# 2. Creates a fixup commit for staged files.
# 3. Executes an immediate non-interactive autosquash rebase.
function gfix() {
    # Check for staged changes
    if git diff --cached --quiet; then
        echo -e "\033[1;33m⚠️  No hay archivos en el stage area.\033[0m"
        return 1
    fi

    # Select target commit
    local target
    target=$(git log -n 20 --color=always --pretty=format:'%C(auto)%h %s %C(green)(%cr) %C(bold blue)<%an>%C(reset)' | \
        fzf --ansi --no-multi --header "🎯 Select commit to fixup" --height=40% --layout=reverse --border)

    [[ -z "$target" ]] && return 0

    local hash=$(echo "$target" | awk '{print $1}')

    # Create fixup commit
    git commit --fixup "$hash"

    # Autosquash rebase
    # We use GIT_EDITOR=true to make it non-interactive
    GIT_EDITOR=true git rebase -i --autosquash "${hash}^"
    
    echo -e "\033[1;32m✅ Fixup aplicado y rebase completado para $hash\033[0m"
}

# [git] Gitignore Interactive Generator (ggi)
# Genera o añade reglas al .gitignore usando la API de gitignore.io y FZF.
# Permite combinar múltiples tecnologías (ej: python + django + docker).
function ggi() {
    local api_url="https://www.toptal.com/developers/gitignore/api"
    
    # 1. Obtener lista de tipos soportados (con cache temporal de 1 día para velocidad)
    local cache_file="/tmp/gitignore_types.txt"
    if [[ ! -f "$cache_file" || $(find "$cache_file" -mmin +1440) ]]; then
        echo -e "\033[1;34m🔍 Actualizando lista de tecnologías...\033[0m"
        curl -sL "${api_url}/list?format=lines" > "$cache_file" 2>/dev/null
    fi

    # 2. Selector FZF (Multi-selección con TAB)
    local selected
    selected=$(cat "$cache_file" | fzf -m \
        --header "TAB: seleccionar varias | ENTER: generar | CTRL-R: actualizar lista" \
        --height=60% --layout=reverse --border \
        --prompt="🚀 Tecnología > " \
        --preview "curl -sL ${api_url}/{} | head -50")

    [[ -z "$selected" ]] && return 0

    # 3. Transformar selección para la URL (comas en lugar de espacios/newlines)
    local targets
    targets=$(echo "$selected" | tr '\n' ',' | sed 's/,$//')

    # 4. Descargar y procesar
    echo -e "\033[1;34m📥 Descargando reglas para: $targets...\033[0m"
    local content
    content=$(curl -sL "${api_url}/${targets}")

    if [[ -z "$content" || "$content" == *"#!! ERROR"* ]]; then
        echo -e "\033[1;31m❌ Error: No se pudo obtener el contenido de la API o la tecnología no existe.\033[0m"
        return 1
    fi

    # 5. Escribir al archivo
    if [[ -f ".gitignore" ]]; then
        echo -e "\n# --- Added by ggi ($(date +'%Y-%m-%d %H:%M')): $targets ---" >> .gitignore
        echo "$content" | sed '/^# Created by/d' >> .gitignore
        echo -e "\033[1;32m✅ Reglas añadidas a tu .gitignore actual.\033[0m"
    else
        echo "$content" > .gitignore
        echo -e "\033[1;32m✅ .gitignore creado con éxito para: $targets\033[0m"
    fi
}

# [git] Gitignore Add (gi_add)
# Añade una regla al .gitignore solo si no existe.
# Uso: gi_add ".env" "Security"
function gi_add() {
    local pattern=$1
    local comment=$2
    local file=".gitignore"

    [[ -z "$pattern" ]] && return 1
    
    # Crear archivo si no existe
    [[ ! -f "$file" ]] && touch "$file"

    # Verificar si ya existe el patrón (evitar duplicados)
    if ! grep -q "^${pattern//./\.}$" "$file" 2>/dev/null; then
        if [[ -n "$comment" ]]; then
            # Solo añadir comentario si no existe ya esa sección
            if ! grep -q "# $comment" "$file" 2>/dev/null; then
                echo -e "\n# $comment" >> "$file"
            fi
        fi
        echo "$pattern" >> "$file"
        return 0
    fi
    return 1
}
