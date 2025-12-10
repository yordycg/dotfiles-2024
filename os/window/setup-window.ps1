# 1. Boilerplate: Verificar y solicitar privilegios de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "El script necesita privilegios de administrador. Reiniciando..."
    Start-Process -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# 2. Iniciar registro de actividad
$LogPath = Join-Path -Path $PSScriptRoot -ChildPath "install-log.txt"
Start-Transcript -Path $LogPath -Append
Write-Host "Ejecutando script como administrador. Registro de actividad iniciado en '$LogPath'."

# 3. Cargar funciones y configuración
Write-Host "Cargando configuración y funciones..."
try {
    $config = Get-Content -Raw -Path (Join-Path -Path $PSScriptRoot -ChildPath "config\config.json") | ConvertFrom-Json
    
    # Cargar funciones auxiliares
    Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath "functions") -Filter *.ps1 | ForEach-Object { . $_.FullName }
}
catch {
    Write-Error "Error fatal: No se pudo cargar la configuración o las funciones. Razón: $($_.Exception.Message)"
    Stop-Transcript
    exit 1
}

# 4. Resolver todas las rutas desde la configuración
Write-Host "Resolviendo rutas de configuración..."
$resolvedPaths = @{}
$config.paths.PSObject.Properties | ForEach-Object {
    $resolvedPaths[$_.Name] = Resolve-Path -Path $_.Value -ConfigPaths $config.paths
}

# 5. Crear directorios
Write-Host "Creando directorios definidos en la configuración..."
foreach ($dir in $config.directoriesToCreate) {
    $resolvedDir = Resolve-Path -Path $dir -ConfigPaths $resolvedPaths
    New-Directory -Path $resolvedDir -Force
}

# 6. Instalar y actualizar Scoop y aplicaciones
Write-Host "Instalando y actualizando Scoop y aplicaciones..."
Install-Scoop
Install-ScoopAps -Apps $config.scoopApps

# 6.5. Configurar claves SSH para Git
Write-Host "Ejecutando script de configuración de claves SSH para Git..."
try {
    # El script de SSH está escrito en PowerShell Core (pwsh) para ser multiplataforma.
    # Lo llamamos explícitamente con pwsh.exe.
    $sshScriptPath = Resolve-Path (Join-Path $PSScriptRoot '..\..\git\setup-git-ssh.ps1')
    pwsh.exe -File $sshScriptPath
}
catch {
    Write-Warning "El script de configuración de SSH falló. Puede que necesites configurarlo manualmente. Error: $($_.Exception.Message)"
    # Decidimos no detener todo el script si esto falla, pero sí advertir al usuario.
}

# 7. Clonar y actualizar repositorios
Write-Host "Clonando y actualizando repositorios..."
foreach ($repo in $config.repositories) {
    $destination = Resolve-Path -Path $repo.destination -ConfigPaths $resolvedPaths
    Sync-Repository -RepoName $repo.name -DestinationPath $destination
}

# 8. Crear enlaces simbólicos
Write-Host "Creando enlaces simbólicos..."
foreach ($symlink in $config.symlinks) {
    $target = Resolve-Path -Path $symlink.target -ConfigPaths $resolvedPaths
    $link = Resolve-Path -Path $symlink.link -ConfigPaths $resolvedPaths
    New-Symlink -TargetPath $target -LinkPath $link -Force
}

# 9. Configurar perfil de PowerShell
Write-Host "Configurando perfil de PowerShell..."
$profileLine = Resolve-Path -Path $config.powershellProfileLine -ConfigPaths $resolvedPaths
Set-PowerShellProfile -ProfileContent $profileLine

# 10. Finalizar
Write-Host "Proceso completado."
Stop-Transcript
Write-Host "Registro de actividad guardado en '$LogPath'."
