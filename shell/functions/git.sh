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
