function tmux {
    # Check if psmux is installed
    if (-not (Get-Command psmux -ErrorAction SilentlyContinue)) {
        Write-Host '❌ psmux no está instalado.' -ForegroundColor Red
        return
    }

    # Attach to session or start a new one
    # Note: psmux-continuum and resurrect plugins (configured in psmux.conf)
    # will handle automatic restoration upon starting psmux.
    psmux attach 2>$null
    if ($LASTEXITCODE -ne 0) {
        psmux
    }
}
