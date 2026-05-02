# Buscar y seleccionar una rama git
function fgb {
    git branch | fzf --height 40% | ForEach-Object { $_.Trim() } | Set-Variable -Name branch
    if ($branch) {
        git checkout $branch
    }
}

# Ver y explorar commits
function fgl {
    git log --oneline | fzf --preview 'echo {} | cut -d " " -f 1 | xargs git show --color=always' | ForEach-Object { $_.Split(' ')[0] }
}

# Ver y aplicar stash
function fgs {
    git stash list | fzf --preview 'echo {} | cut -d ":" -f 1 | xargs git stash show -p --color=always' | ForEach-Object {
        $stash = $_.Split(':')[0]
        git stash apply $stash
    }
}