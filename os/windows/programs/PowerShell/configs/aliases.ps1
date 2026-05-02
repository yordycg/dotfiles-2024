# -----------------------------------------------------------------------------
# System Functions & Aliases
# -----------------------------------------------------------------------------

# PowerShell aliases don't support arguments. We use functions instead.
function shutdown { & shutdown.exe /s /t 0 }
function restart  { & shutdown.exe /r /t 0 }
function c        { Clear-Host }
function x        { exit }
function v        { nvim $args }
function vi       { nvim $args }
function vim      { nvim $args }
function grep     { findstr $args }

# Navigation
function ..    { cd .. }
function ...   { cd ..\.. }
function ....  { cd ..\..\.. }
function ~     { cd $HOME }

# Modern replacements (only if installed)
if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat { bat $args }
}

if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    Set-Alias -Name ff -Value fastfetch
}

# Git & Tools
Set-Alias -Name g -Value git
Set-Alias -Name lg -Value lazygit
Set-Alias -Name ld -Value lazydocker
Set-Alias -Name d -Value docker
Set-Alias -Name dc -Value docker-compose
Set-Alias -Name pn -Value pnpm

# Navigation Helpers
function ws { 
    $path = Join-Path $HOME "workspace"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path | Out-Null }
    Set-Location $path 
}

function ii { 
    $path = Join-Path $HOME "workspace\ing-informatica"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path | Out-Null }
    Set-Location $path 
}

function mkcd {
    param([string]$Path)
    if (-not $Path) { return }
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}
