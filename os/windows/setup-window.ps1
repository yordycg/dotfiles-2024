# ----------------------------------------------------------------------
# Windows Setup Orchestrator
# ----------------------------------------------------------------------
param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("All", "Directories", "Links", "Scoop", "SSH", "Repos", "Profile")]
    [string]$Task = "All"
)

# 0. Asegurar privilegios de administrador para symlinks
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚀 Solicitando permisos de administrador para tareas del sistema..." -ForegroundColor Cyan
    
    # IMPORTANTE: Usamos el mismo ejecutable que nos está corriendo (pwsh o powershell)
    $PSExe = (Get-Process -Id $PID).Path
    $Arguments = "-NoExit -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`" -Task $Task"
    
    try {
        Start-Process -FilePath $PSExe -ArgumentList $Arguments -Verb RunAs -ErrorAction Stop
    } catch {
        Write-Error "No se pudo iniciar el proceso con privilegios de administrador: $($_.Exception.Message)"
    }
    exit
}

# Asegurar que estamos en el directorio del script
Set-Location $PSScriptRoot

# --- CARGA CRÍTICA DEL MÓDULO ---
try {
    $ModulePath = Join-Path $PSScriptRoot "lib\WinDotfiles.psm1"
    if (-not (Test-Path $ModulePath)) { throw "Módulo WinDotfiles no encontrado en $ModulePath" }
    Import-Module $ModulePath -Force
    
    $ConfigPath = Join-Path $PSScriptRoot "config\config.json"
    if (-not (Test-Path $ConfigPath)) { throw "Archivo de configuración no encontrado en $ConfigPath" }
    $config = Get-Content -Raw $ConfigPath | ConvertFrom-Json
}
catch {
    Write-Host "`n❌ FALLO CRÍTICO al cargar módulos/config: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$LogPath = Join-Path $PSScriptRoot "install-log.txt"
if ($Task -eq "All" -and (Test-Path $LogPath)) { Remove-Item $LogPath -Force }
Start-Transcript -Path $LogPath -Append
Write-Host "--- Iniciando Configuración de Windows (Tarea: $Task) ---" -ForegroundColor Cyan

# 2. Resolver Rutas Base
Write-Host "Resolviendo rutas de configuración..."
$resolvedPaths = @{}
foreach ($prop in $config.paths.PSObject.Properties) {
    $resolvedPaths[$prop.Name] = $prop.Value
}
$resolvedPaths["userprofile"] = $env:USERPROFILE
$resolvedPaths["localappdata"] = $env:LOCALAPPDATA

foreach ($key in @($resolvedPaths.Keys)) {
    try {
        $resolvedPaths[$key] = Resolve-ConfigPath -Path $resolvedPaths[$key] -ConfigPaths $resolvedPaths
    } catch {
        Write-Warning "No se pudo resolver la ruta '$key': $($_.Exception.Message)"
    }
}

# 3. Ejecución de Tareas

# --- DIRECTORIOS ---
if ($Task -eq "All" -or $Task -eq "Directories" -or $Task -eq "Links") {
    Write-Host "`nStep 1: Creando directorios..." -ForegroundColor Yellow
    foreach ($dir in $config.directoriesToCreate) {
        $resolvedDir = Resolve-ConfigPath -Path $dir -ConfigPaths $resolvedPaths
        New-Directory -Path $resolvedDir -Force
    }
}

# --- ENLACES SIMBÓLICOS ---
if ($Task -eq "All" -or $Task -eq "Links") {
    Write-Host "`nStep 2: Creando Enlaces Simbólicos..." -ForegroundColor Yellow
    foreach ($symlink in $config.symlinks) {
        $target = Resolve-ConfigPath -Path $symlink.target -ConfigPaths $resolvedPaths
        $link = Resolve-ConfigPath -Path $symlink.link -ConfigPaths $resolvedPaths
        New-Symlink -TargetPath $target -LinkPath $link -Force
    }
}

# --- SCOOP ---
if ($Task -eq "All" -or $Task -eq "Scoop") {
    Write-Host "`nStep 3: Instalando Scoop y Aplicaciones..." -ForegroundColor Yellow
    Install-Scoop
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Install-ScoopApps -Apps $config.scoopApps
}

# --- SSH & GIT ---
if ($Task -eq "All" -or $Task -eq "SSH") {
    Write-Host "`nStep 4: Configurando SSH y Git..." -ForegroundColor Yellow
    try {
        $sshScriptPath = Resolve-Path (Join-Path $PSScriptRoot "..\..\git\setup-git-ssh.ps1")
        if (Test-Path $sshScriptPath) {
            & pwsh.exe -NoProfile -File $sshScriptPath -Config $config
        }
    } catch {
        Write-Warning "No se pudo ejecutar la configuración de SSH: $($_.Exception.Message)"
    }
}

# --- REPOSITORIOS ---
if ($Task -eq "All" -or $Task -eq "Repos") {
    Write-Host "`nStep 5: Sincronizando Repositorios..." -ForegroundColor Yellow
    foreach ($repo in $config.repositories) {
        $dest = Resolve-ConfigPath -Path $repo.destination -ConfigPaths $resolvedPaths
        Sync-Repository -RepoName $repo.name -DestinationPath $dest
    }
}

# --- PERFIL POWERSHELL ---
if ($Task -eq "All" -or $Task -eq "Profile" -or $Task -eq "Links") {
    Write-Host "`nStep 6: Configurando Perfil de PowerShell..." -ForegroundColor Yellow
    $rawLine = Resolve-ConfigPath -Path $config.powershellProfileLine -ConfigPaths $resolvedPaths
    if ($null -ne $rawLine) {
        $cleanPath = $rawLine.Replace(". ", "").Trim(' "')
        $profileLine = ". `"$cleanPath`""
        Set-PowerShellProfile -ProfileContent $profileLine
    }
}

Write-Host "`n--- Configuración de Windows Finalizada ---" -ForegroundColor Green
Stop-Transcript
