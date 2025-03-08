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

# Alias
# Set-Alias -Name nv -Value nvim
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function dev { cd "D:\Escritorio 2\Cursos-Yordy\00 - Cursos Programacion" }
function ws {
    $fixedPath = "$env:USERPROFILE\workspace"

    if (!(Test-Path $fixedPath)) {
        New-Item -ItemType Directory -Path $fixedPath -Force
        Write-Host "`nDirectorio '$fixedPath' creado correctamente!"
    }
    else {
        Write-Host "Ir al directorio '$fixedPath'..."
        cd "$env:USERPROFILE\workspace"
    }
}

# TODO: solucionar error, no toma la variable $fixedPath
function ii {
    $fixedPath = "$env:USERPROFILE\workspace\ing_informatica"

    if (!(Test-Path $fixedPath)) {
        # Crear directorio 'workspace'
        # ws
        New-Item -ItemType Directory -Path $fixedPath -Force
        Write-Host "`nDirectorio '$fixedPath' creado correctamente!"
    }
    else {
        Write-Host "Ir al directorio '$fixedPath'..."
        cd "$env:USERPROFILE\workspace\ing_informatica"
    }
}
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function lsa {
    Get-ChildItem -Force
}

## agregar alias a wsl.exe
function ub {
    param (
        [string]$argument
    )

    # Verifica si se proporcionó un argumento
    if ($argument) {
        # Ejecuta el comando con el argumento
        wsl.exe $argument
    }
    else {
        # Ejecuta el comando con la ubicación predeterminada
        wsl.exe ~
    }
}

## Node Alias
Set-Alias -Name pn -Value pnpm
function pnd {
    pnpm run dev
}
function npmd {
    npm run dev
}

# Useful shortcuts for traversing directories
function .. { cd ..\ }
function ... { cd ..\.. }
function .... { cd ..\..\.. }
function ..... { cd ..\..\..\.. }
function ...... { cd ..\..\..\..\.. }

function touch($file) {
    "" | Out-FIle $file -Encoding ASCII
}

# fnm
fnm env --use-on-cd | Out-String | Invoke-Expression

# starship prompt
Invoke-Expression (&starship init powershell)
