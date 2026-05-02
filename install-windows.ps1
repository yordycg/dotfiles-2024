# ----------------------------------------------------------------------
# MASTER INSTALLER: Windows Dotfiles
# ----------------------------------------------------------------------
# Este script es el punto de entrada único para Windows.
# Instala Git, clona los dotfiles y ejecuta la configuración.
# ----------------------------------------------------------------------

# 1. Asegurar privilegios de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "🚀 Solicitando permisos de administrador..." -ForegroundColor Cyan
    Start-Process -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Write-Host "==========================================" -ForegroundColor Blue
Write-Host "   🚀 Yordy's Windows Dotfiles Setup      " -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue

# 2. Verificar/Instalar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Git no encontrado. Instalando mediante Winget..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
    # Refrescar el PATH para la sesión actual
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 3. Definir rutas
$DotfilesRepo = "https://github.com/yordycg/dotfiles-2024.git"
$TargetDir = "$env:USERPROFILE\workspace\repos\dotfiles-2024"

# 4. Clonar o actualizar repo
if (-not (Test-Path $TargetDir)) {
    Write-Host "📥 Clonando repositorio de dotfiles..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path (Split-Path $TargetDir)
    git clone $DotfilesRepo $TargetDir
} else {
    Write-Host "📂 El repositorio ya existe. Actualizando..." -ForegroundColor Green
    Push-Location $TargetDir
    git pull origin main
    Pop-Location
}

# 5. Ejecutar el script principal de Windows
$WindowsSetup = Join-Path $TargetDir "os\windows\setup-window.ps1"
if (Test-Path $WindowsSetup) {
    Write-Host "⚙️ Ejecutando configuración de Windows..." -ForegroundColor Yellow
    Set-Location (Split-Path $WindowsSetup)
    & powershell.exe -ExecutionPolicy Bypass -File $WindowsSetup
} else {
    Write-Error "❌ No se encontró el script de configuración en $WindowsSetup"
}

Write-Host "==========================================" -ForegroundColor Blue
Write-Host "   ✨ Proceso finalizado en Windows!      " -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue
