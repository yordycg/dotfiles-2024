# ----------------------------------------------------------------------
# Windows Setup Orchestrator
# ----------------------------------------------------------------------

# Asegurar que estamos en el directorio del script
Set-Location $PSScriptRoot

$LogPath = Join-Path $PSScriptRoot "install-log.txt"
if (Test-Path $LogPath) { Remove-Item $LogPath -Force }
Start-Transcript -Path $LogPath -Append
Write-Host "--- Iniciando Configuración de Windows ---" -ForegroundColor Cyan

# 1. Cargar Módulo y Configuración
try {
    $ModulePath = Join-Path $PSScriptRoot "lib\WinDotfiles.psm1"
    if (-not (Test-Path $ModulePath)) { throw "Módulo WinDotfiles no encontrado en $ModulePath" }
    Import-Module $ModulePath -Force
    
    $ConfigPath = Join-Path $PSScriptRoot "config\config.json"
    if (-not (Test-Path $ConfigPath)) { throw "Archivo de configuración no encontrado en $ConfigPath" }
    $config = Get-Content -Raw $ConfigPath | ConvertFrom-Json
}
catch {
    Write-Host "`n❌ FALLO CRÍTICO: $($_.Exception.Message)" -ForegroundColor Red
    Stop-Transcript; exit 1
}

# 2. Resolver Rutas Base
Write-Host "Resolviendo rutas de configuración..."
$resolvedPaths = @{}
# Convertimos el objeto de paths a un hashtable para el resolvedor
foreach ($prop in $config.paths.PSObject.Properties) {
    $resolvedPaths[$prop.Name] = $prop.Value
}
# Inyectamos valores reales
$resolvedPaths["userprofile"] = $env:USERPROFILE
$resolvedPaths["localappdata"] = $env:LOCALAPPDATA

# Resolver recursivamente
foreach ($key in @($resolvedPaths.Keys)) {
    try {
        $resolvedPaths[$key] = Resolve-ConfigPath -Path $resolvedPaths[$key] -ConfigPaths $resolvedPaths
    } catch {
        Write-Warning "No se pudo resolver la ruta '$key': $($_.Exception.Message)"
    }
}

# 3. Ejecución de Tareas
Write-Host "`nStep 1: Creando directorios..." -ForegroundColor Yellow
foreach ($dir in $config.directoriesToCreate) {
    $resolvedDir = Resolve-ConfigPath -Path $dir -ConfigPaths $resolvedPaths
    New-Directory -Path $resolvedDir -Force
}

Write-Host "`nStep 2: Instalando Scoop y Aplicaciones..." -ForegroundColor Yellow
Install-Scoop
# Refrescar PATH para la sesión actual
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Install-ScoopApps -Apps $config.scoopApps

Write-Host "`nStep 3: Configurando SSH y Git..." -ForegroundColor Yellow
try {
    $sshScriptPath = Resolve-Path (Join-Path $PSScriptRoot "..\..\git\setup-git-ssh.ps1")
    if (Test-Path $sshScriptPath) {
        & pwsh.exe -File $sshScriptPath -Config $config
    }
} catch {
    Write-Warning "No se pudo ejecutar la configuración de SSH: $($_.Exception.Message)"
}

Write-Host "`nStep 4: Sincronizando Repositorios..." -ForegroundColor Yellow
foreach ($repo in $config.repositories) {
    $dest = Resolve-ConfigPath -Path $repo.destination -ConfigPaths $resolvedPaths
    Sync-Repository -RepoName $repo.name -DestinationPath $dest
}

Write-Host "`nStep 5: Creando Enlaces Simbólicos..." -ForegroundColor Yellow
foreach ($symlink in $config.symlinks) {
    $target = Resolve-ConfigPath -Path $symlink.target -ConfigPaths $resolvedPaths
    $link = Resolve-ConfigPath -Path $symlink.link -ConfigPaths $resolvedPaths
    New-Symlink -TargetPath $target -LinkPath $link -Force
}

Write-Host "`nStep 6: Configurando Perfil de PowerShell..." -ForegroundColor Yellow
$profileLine = Resolve-ConfigPath -Path $config.powershellProfileLine -ConfigPaths $resolvedPaths
Set-PowerShellProfile -ProfileContent $profileLine

Write-Host "`n--- Configuración de Windows Finalizada ---" -ForegroundColor Green
Stop-Transcript
