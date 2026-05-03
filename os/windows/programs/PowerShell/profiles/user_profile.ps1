# -----------------------------------------------------------------------------
# PowerShell User Profile (Senior Edition) - Optimized for Starship
# -----------------------------------------------------------------------------

# 1. Performance & Encoding
$ProgressPreference = 'SilentlyContinue'
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# 2. Path Detection
# Buscamos la carpeta de configs relativa a este perfil o en la ruta estándar
$DotfilesRoot = "$HOME\workspace\infra\dotfiles-2024"
$PSConfigPath = Join-Path $DotfilesRoot "os\windows\programs\PowerShell\configs"

# 3. Dynamic Function Loading
if (Test-Path $PSConfigPath) {
    # Carga de Aliases primero
    $aliasFile = Join-Path $PSConfigPath "aliases.ps1"
    if (Test-Path $aliasFile) { . $aliasFile }

    # Carga automática de todas las funciones especializadas
    $functionsPath = Join-Path $PSConfigPath "functions"
    if (Test-Path $functionsPath) {
        Get-ChildItem -Path $functionsPath -Filter *.ps1 | ForEach-Object {
            . $_.FullName
        }
    }
}

# 4. Defensive Module Loading
function Import-Module-Safe($Name) {
    if (Get-Module -ListAvailable -Name $Name) { 
        Import-Module $Name -ErrorAction SilentlyContinue 
    }
}

Import-Module-Safe "posh-git"
Import-Module-Safe "Terminal-Icons"
Import-Module-Safe "PSFzf"

# 5. PSReadLine (Modern Terminal Experience)
if (Get-Module -ListAvailable -Name "PSReadLine") {
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
}

# 6. Tool Initializations (Only if they exist)
# FNM (Node Version Manager)
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}

# Starship Prompt (Rust powered)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# 7. Global Environment Variables for Tools
$env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border --color=hl:#2dd4bf"
$env:STARSHIP_CONFIG = Join-Path $DotfilesRoot "os\cross-platform\starship\starship.toml"
