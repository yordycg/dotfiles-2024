# -----------------------------------------------------------------------------
# Windows-WSL Bridge Functions
# -----------------------------------------------------------------------------

# Acceso rápido al Homelab (Lanza WSL y conecta)
function hl {
    param([string]$session = "main")
    Write-Host "󰇄 Conectando a Homelab ($session)..." -ForegroundColor Cyan
    wsl -d Ubuntu-24.04 -- bash -ic "~/.local/bin/hl $session"
}

function hls { 
    Write-Host "󰇄 Listando sesiones en Homelab..." -ForegroundColor Cyan
    wsl -d Ubuntu-24.04 -- bash -ic "hls" 
}

# Alias rápidos
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
Set-Alias -Name ll -Value ls -ErrorAction SilentlyContinue

# Aplicar cambios de Windows (dotfiles-2024)
function win-apply {
    $repoPath = "$HOME\workspace\infra\dotfiles-2024"
    if (Test-Path $repoPath) {
        Push-Location $repoPath
        Write-Host "▶ Actualizando dotfiles de Windows..." -ForegroundColor Cyan
        git pull
        ./install-windows.ps1
        Pop-Location
    }
}
