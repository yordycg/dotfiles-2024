# Iniciar script en modo 'Admin'
# Verificar si el script se está ejecutando como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # El script no se está ejecutando como administrador, así que lo reiniciamos con privilegios elevados
    Write-Warning "El script necesita privilegios de administrador. Reiniciando..."
    Start-Process -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit # Salir de la instancia actual del script
}

# El script se está ejecutando como administrador, aquí va el resto de tu código
Write-Host "Ejecutando script como administrador..."
Write-Host "Cargando archivos..."

# Cargar variables globales
. "$PSScriptRoot\config\Global-Vars.ps1"

# Cargar funciones
. "$PSScriptRoot\functions\New-Directory.ps1"
. "$PSScriptRoot\functions\Install-Scoop.ps1"
. "$PSScriptRoot\functions\Install-ScoopAps.ps1"
. "$PSScriptRoot\functions\Get-Repository.ps1"
. "$PSScriptRoot\functions\New-Symlink.ps1"
. "$PSScriptRoot\functions\Set-PowerShellProfile.ps1"

# Cargar scripts

# Instalar programas
# . scripts\install-chrome.ps1
# . scripts\install-vscode.ps1

# Llamando a las funciones
Write-Host "Creando directorios..."
New-Directory -Path $configPath -Force
New-Directory -Path $powershellConfigPath -Force
New-Directory -Path $workspacePath -Force
New-Directory -Path $reposPath -Force
New-Directory -Path "$workspacePath\repos\ipvg" -Force
New-Directory -Path "$workspacePath\repos\personal" -Force
New-Directory -Path "$workspacePath\repos\work" -Force

Write-Host "Scoop..."
Install-Scoop
Install-ScoopAps -Apps $scoopApps

Write-Host "Clonar Repositorios..."
Get-Repository -RepoName "dotfiles-2024.git" -DestinationPath $dotfilesPath
Get-Repository -RepoName "obsidian-notes.git" -DestinationPath $obsidianPath
Get-Repository -RepoName "wallpapers.git" -DestinationPath $wallpapersPath

Write-Host "Crear Symlinks..."
New-Symlink -TargetPath $gitConfigDotfilesPath -LinkPath $gitConfig
# ERROR al crear los Symlink
New-Symlink -TargetPath $gitConfigIPVGDotfilesPath -LinkPath $gitConfigIPVG
New-Symlink -TargetPath $gitConfigPERSONALDotfilesPath -LinkPath $gitConfigPERSONAL
New-Symlink -TargetPath $gitConfigWORKDotfilesPath -LinkPath $gitConfigWORK
New-Symlink -TargetPath $starshipDotfilesPath -LinkPath $starshipPath
New-Symlink -TargetPath $profilePSDotfilesPath -LinkPath $userProfileConfigPath
New-Symlink -TargetPath $confWinTerminalDotfilesPath -LinkPath $confWinTerminalPath -Force

# Setup PowerShell
Set-PowerShellProfile -ProfileContent $ProfilePSContent

# Instalando programas
Write-Host "Instalando programas..."

Write-Host "Adios."