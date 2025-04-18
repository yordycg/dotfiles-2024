# set Powershell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

oh-my-posh init pwsh | Invoke-Expression

#  Import-Module
Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\themes\spaceship.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Import custom config
$customConfigPath = Join-Path -Path $HOME -ChildPath "workspace\dotfiles\os\window\programs\PowerShell\configs"
$functionsPath = Join-Path -Path $customConfigPath -ChildPath "functions"

# Import functions
if (Test-Path -Path $functionsPath) {
  . "$functionsPath\docker-functions.ps1"
  . "$functionsPath\fzf-git-functions.ps1"
  . "$functionsPath\gh-functions.ps1"
  . "$functionsPath\git-functions.ps1"
  . "$functionsPath\pnpm-functions.ps1"
  . "$functionsPath\utils-functions.ps1"
} else {
  Write-Warning "No se encontraron los funciones en el directorio: $functionsPath"
}
. "$env:USERPROFILE\workspace\dotfiles\os\window\programs\PowerShell\configs\aliases.ps1"

# Alias
# # Set-Alias -Name nv -Value nvim
# Set-Alias v nvim
# Set-Alias ll ls
# Set-Alias g git
# Set-Alias grep findstr
# Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
# Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# # Utilities
# function dev { cd "D:\Escritorio 2\Cursos-Yordy\00 - Cursos Programacion" }
# function ws {
#     $fixedPath = "$env:USERPROFILE\workspace"

#     if (!(Test-Path $fixedPath)) {
#         New-Item -ItemType Directory -Path $fixedPath -Force
#         Write-Host "`nDirectorio '$fixedPath' creado correctamente!"
#     }
#     else {
#         Write-Host "Ir al directorio '$fixedPath'..."
#         cd "$env:USERPROFILE\workspace"
#     }
# }

# function ii {
#     $fixedPath = "$env:USERPROFILE\workspace\ing_informatica"

#     if (!(Test-Path $fixedPath)) {
#         # Crear directorio 'workspace'
#         # ws
#         New-Item -ItemType Directory -Path $fixedPath -Force
#         Write-Host "`nDirectorio '$fixedPath' creado correctamente!"
#     }
#     else {
#         Write-Host "Ir al directorio '$fixedPath'..."
#         cd "$env:USERPROFILE\workspace\ing_informatica"
#     }
# }
# function which ($command) {
#     Get-Command -Name $command -ErrorAction SilentlyContinue |
#     Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
# }

# function lsa {
#     Get-ChildItem -Force
# }

# ## agregar alias a wsl.exe
# function ub {
#     param (
#         [string]$argument
#     )

#     # Verifica si se proporcionó un argumento
#     if ($argument) {
#         # Ejecuta el comando con el argumento
#         wsl.exe $argument
#     }
#     else {
#         # Ejecuta el comando con la ubicación predeterminada
#         wsl.exe ~
#     }
# }

# ## Node Alias
# Set-Alias -Name pn -Value pnpm
# function pnd {
#     pnpm run dev
# }
# function npmd {
#     npm run dev
# }

# # Useful shortcuts for traversing directories
# function .. { cd ..\ }
# function ... { cd ..\.. }
# function .... { cd ..\..\.. }
# function ..... { cd ..\..\..\.. }
# function ...... { cd ..\..\..\..\.. }

# function touch($file) {
#     "" | Out-FIle $file -Encoding ASCII
# }

# Config fzf
# Configuración de fzf para PowerShell
$env:FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_CTRL_T_COMMAND=$env:FZF_DEFAULT_COMMAND
$env:FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_DEFAULT_OPTS="--height 50% --layout=reverse --info=inline-right --border=rounded --color=hl:#2dd4bf"
$env:FZF_TMUX_OPTS=" -p70%,70% "

# Configuración de previsualización
$env:FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always -n --line-range :500 {}'"
$env:FZF_ALT_C_OPTS="--preview 'ls -l {} | head -200'"  # Ajusta esto según qué herramienta uses para listar directorios

# fnm
fnm env --use-on-cd | Out-String | Invoke-Expression

# starship prompt
Invoke-Expression (&starship init powershell)
