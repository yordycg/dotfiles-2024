function tmux {
    # Check if psmux is installed
    if (-not (Get-Command psmux -ErrorAction SilentlyContinue)) {
        Write-Host '❌ psmux no está instalado.' -ForegroundColor Red
        return
    }

    # Attach to session or start a new one
    psmux attach 2>$null
    if ($LASTEXITCODE -ne 0) {
        psmux
    }
}

function psms {
    <#
    .SYNOPSIS
        Advanced Fuzzy session picker for psmux.
        Support: Alt-a (Add), Alt-d (Delete), Enter (Attach)
    #>
    if (-not (Get-Command psmux -ErrorAction SilentlyContinue)) {
        Write-Host '❌ psmux no está instalado.' -ForegroundColor Red
        return
    }

    $fzf_header = "ENTER: Attach | ALT-A: Add Session | ALT-D: Delete Session"
    
    # Run FZF with custom keybindings
    # --expect allows us to know which key was pressed
    $fzf_out = psmux ls -F "#{session_name}" 2>$null | fzf `
        --reverse `
        --header="$fzf_header" `
        --expect="alt-a,alt-d" `
        --preview="psmux list-windows -t {}" --preview-window="right:40%:wrap"

    if (-not $fzf_out) { return }

    $key = $fzf_out[0]
    $selection = $fzf_out[1]

    switch ($key) {
        "alt-a" {
            $name = Read-Host "New session name"
            if ($name) {
                psmux new-session -d -s $name
                psmux attach -t $name
            }
        }
        "alt-d" {
            if ($selection) {
                psmux kill-session -t $selection
                Write-Host "🗑️ Session '$selection' deleted." -ForegroundColor Yellow
                # Recursively call psms to refresh the list
                psms
            }
        }
        Default {
            if ($selection) {
                psmux attach -t $selection
            }
        }
    }
}
