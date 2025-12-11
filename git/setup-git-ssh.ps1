#!/usr/bin/env pwsh
# Nombre del script: setup-git-ssh.ps1

# Aceptamos el objeto de configuración como parámetro
param (
    [Parameter(Mandatory = $false)]
    [object]$Config
)

# --- Funciones Auxiliares ---

function Get-HomeDirectory {
    if ($IsWindows) { return $env:USERPROFILE }
    if ($IsLinux -or $IsMacOS) { return $env:HOME }
    return $null
}

function Ensure-SshAgentRunning {
    Write-Host "Asegurando que el agente SSH esté corriendo..."
    if ($IsWindows) {
        $agentService = Get-Service -Name ssh-agent -ErrorAction SilentlyContinue
        if (-not $agentService) {
            Write-Warning "El servicio 'ssh-agent' no se encontró."
            return $false
        }
        if ($agentService.Status -ne "Running") {
            try {
                Set-Service -Name ssh-agent -StartupType Automatic -ErrorAction Stop
                Start-Service -Name ssh-agent -ErrorAction Stop
                Write-Host "Servicio ssh-agent configurado como automático e iniciado."
            }
            catch {
                Write-Warning "No se pudo iniciar ssh-agent: $($_.Exception.Message)"
                return $false
            }
        }
        return $true
    }
    return $true # En Linux/Mac se asume manejado por el sistema o script padre
}
function Generate-AndAddSshKey {
    param($Email, $KeyPath, $KeyComment)

    if (Test-Path $KeyPath) {
        Write-Warning "La clave SSH ya existe en '$KeyPath'. Saltando generación."
    }
    else {
        Write-Host "Generando clave para '$KeyComment' ($Email)..."
        # CORRECCIÓN: Quitamos -ErrorAction porque ssh-keygen no lo soporta
        ssh-keygen -t ed25519 -C "$Email ($KeyComment)" -f $KeyPath -N "" | Out-Null

        if ($LASTEXITCODE -ne 0) {
            Write-Error "Fallo al generar clave. Código de salida: $LASTEXITCODE"
            return $false
        }
        Write-Host "Clave generada."
    }

    Write-Host "Añadiendo clave al agente..."
    # CORRECCIÓN: Quitamos -ErrorAction para ssh-add también
    ssh-add $KeyPath 2>&1 | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Clave añadida."
    }
    else {
        Write-Warning "No se pudo añadir la clave al agente automáticamente. Puedes hacerlo manual con 'ssh-add $KeyPath'."
    }
    return $true
}

# --- Lógica Principal ---

$sshDir = Join-Path (Get-HomeDirectory) ".ssh"
$sshConfigPath = Join-Path $sshDir "config"

Write-Host "Iniciando configuración de claves SSH..."

if (-not (Test-Path $sshDir)) {
    New-Item -Path $sshDir -ItemType Directory -Force | Out-Null
}

if (-not (Ensure-SshAgentRunning)) {
    Write-Warning "El agente SSH no está disponible. Continuando, pero la carga de claves podría fallar."
}

# Obtener emails desde el objeto Config o usar valores por defecto
$personalEmail = "user@example.com"
$workEmail = "work@example.com"

if ($Config -and $Config.emails) {
    if ($Config.emails.personal) { $personalEmail = $Config.emails.personal }
    if ($Config.emails.work) { $workEmail = $Config.emails.work }
}

# 1. Configurar GitHub (Personal)
$githubKeyPath = Join-Path $sshDir "id_ed25519_github"
if (Generate-AndAddSshKey -Email $personalEmail -KeyPath $githubKeyPath -KeyComment "GitHub Personal") {
    $githubConfig = @(
        "`nHost github.com",
        "  HostName github.com",
        "  User git",
        "  IdentityFile $githubKeyPath",
        "  IdentitiesOnly yes"
    )
    $githubConfig | Add-Content -Path $sshConfigPath -Force
}

# 2. Configurar Work (GitLab)
$workKeyPath = Join-Path $sshDir "id_ed25519_work"
# Aquí podrías automatizar el hostname si lo agregaras al json, por ahora lo dejamos fijo o interactivo
$workGitLabHostname = "gitlab.innevo.cl"

if (Generate-AndAddSshKey -Email $workEmail -KeyPath $workKeyPath -KeyComment "GitLab Work") {
    $workConfig = @(
        "`nHost $workGitLabHostname",
        "  HostName $workGitLabHostname",
        "  User git",
        "  IdentityFile $workKeyPath",
        "  IdentitiesOnly yes"
    )
    $workConfig | Add-Content -Path $sshConfigPath -Force
}

Write-Host "--- Configuración SSH Finalizada ---"