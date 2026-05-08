# ----------------------------------------------------------------------
# MASTER INSTALLER: Windows Dotfiles
# ----------------------------------------------------------------------
# Este script es el punto de entrada único para Windows.
# Instala Git, clona los dotfiles y ejecuta la configuración.
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

# 2. Verificar/Instalar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[INFO] Git no encontrado. Instalando mediante Winget..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
    # Refrescar el PATH para la sesión actual
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 3. Definir rutas
$DotfilesRepo = "https://github.com/yordycg/dotfiles-2024.git"
$TargetDir = "$env:USERPROFILE\workspace\infra\dotfiles-2024"

# 4. Clonar o actualizar repo
if (-not (Test-Path $TargetDir)) {
    Write-Host "[INFO] Clonando repositorio de dotfiles..." -ForegroundColor Yellow
    $parentDir = Split-Path $TargetDir
    if (-not (Test-Path $parentDir)) { New-Item -ItemType Directory -Force -Path $parentDir }
    git clone $DotfilesRepo $TargetDir
}
else {
    Write-Host "[INFO] El repositorio ya existe. Actualizando..." -ForegroundColor Green
    Push-Location $TargetDir
    git pull origin main
    Pop-Location
}

# 5. Ejecutar el script principal de Windows
$WindowsSetup = Join-Path $TargetDir "os\windows\setup-window.ps1"
if (Test-Path $WindowsSetup) {
    Write-Host "[INFO] Ejecutando configuración de Windows..." -ForegroundColor Yellow
    & $WindowsSetup
}
else {
    Write-Error "[ERROR] No se encontró el script de configuración en $WindowsSetup"
}

Write-Host "`n==========================================" -ForegroundColor Blue
Write-Host "   Proceso finalizado en Windows!         " -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue

# Mantener la ventana abierta para revisar logs
Write-Host "`nPresiona cualquier tecla para salir..."
$null = [Console]::ReadKey($true)
