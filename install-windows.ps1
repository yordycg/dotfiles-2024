# ----------------------------------------------------------------------
# MASTER INSTALLER: Windows Dotfiles
# ----------------------------------------------------------------------
# Este script es el punto de entrada unico para Windows.
# Instala Git, clona los dotfiles y ejecuta la configuracion.
# ----------------------------------------------------------------------

# 1. Asegurar privilegios de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[INFO] Solicitando permisos de administrador..." -ForegroundColor Cyan
    Start-Process -FilePath powershell.exe -ArgumentList "-NoExit -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Write-Host "==========================================" -ForegroundColor Blue
Write-Host "   Yordy's Windows Dotfiles Setup         " -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue

# 2. Health Check: Internet
Write-Host "[INFO] Verificando conexion a internet..." -ForegroundColor Cyan
try {
    $null = [System.Net.Dns]::GetHostEntry("github.com")
} catch {
    Write-Error "No hay conexion a internet o no se puede resolver github.com. Abortando."
    exit 1
}

# 3. Verificar/Instalar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[INFO] Git no encontrado. Instalando mediante Winget..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
    # Refrescar el PATH para la sesion actual
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 4. Definir rutas
$DotfilesRepo = "https://github.com/yordycg/dotfiles-2024.git"
$TargetDir = "$env:USERPROFILE\workspace\infra\dotfiles-2024"

# 5. Clonar o actualizar repo
if (-not (Test-Path $TargetDir)) {
    Write-Host "[INFO] Clonando repositorio de dotfiles..." -ForegroundColor Yellow
    $parentDir = Split-Path $TargetDir
    if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Force -Path $parentDir | Out-Null }
    git clone $DotfilesRepo $TargetDir
}
else {
    Write-Host "[INFO] El repositorio ya existe. Actualizando..." -ForegroundColor Green
    Push-Location $TargetDir
    git pull origin main
    Pop-Location
}

# 6. Ejecutar el script principal de Windows
$WindowsSetup = Join-Path $TargetDir "os\windows\setup-window.ps1"
if (Test-Path $WindowsSetup) {
    Write-Host "[INFO] Ejecutando configuracion de Windows..." -ForegroundColor Yellow
    & $WindowsSetup
}
else {
    Write-Error "[ERROR] No se encontro el script de configuracion en $WindowsSetup"
}

Write-Host "`n==========================================" -ForegroundColor Blue
Write-Host "   Proceso finalizado en Windows!         " -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue

# Mantener la ventana abierta para revisar logs
Write-Host "`nPresiona cualquier tecla para salir..."
$null = [Console]::ReadKey($true)
