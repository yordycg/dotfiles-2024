#!/usr/bin/env pwsh

# Nombre del script: setup-git-ssh.ps1
# Descripción: Configura claves SSH para múltiples identidades de Git (GitHub, GitLab Work) de forma cross-platform.
# Uso: Ejecutar en PowerShell Core (pwsh) en Windows, Linux o macOS.

# --- Funciones Auxiliares ---

function Get-HomeDirectory {
    # Función para obtener el directorio de inicio del usuario de forma cross-platform
    if ($IsWindows) {
        return (Get-Item env:USERPROFILE).Value
    } elseif ($IsLinux -or $IsMacOS) {
        return (Get-Item env:HOME).Value
    }
    return $null
}

function Get-GitConfigEmail {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    try {
        $content = Get-Content -Path $Path -Raw -ErrorAction Stop
        if ($content -match '(?s)\[user\]\s*`r?`n^\s*email\s*=\s*(.+?)$') {
            return $Matches[1].Trim()
        }
    }
    catch {
        Write-Warning "No se pudo leer o parsear el email del archivo de configuración: '$Path'. Error: $($_.Exception.Message)"
    }
    return $null
}

function Ensure-SshAgentRunning {
    Write-Host "Asegurando que el agente SSH esté corriendo..."
    if ($IsWindows) {
        $agentService = Get-Service -Name ssh-agent -ErrorAction SilentlyContinue
        if (-not $agentService) {
            Write-Warning "El servicio 'ssh-agent' no se encontró. Asegúrate de que OpenSSH Client esté instalado (Características Opcionales de Windows)."
            # Intentar instalarlo? Podría ser muy intrusivo. Dejar manual por ahora.
            return $false
        }
        if ($agentService.Status -ne "Running") {
            try {
                Set-Service -Name ssh-agent -StartupType Automatic -ErrorAction Stop
                Start-Service -Name ssh-agent -ErrorAction Stop
                Write-Host "Servicio ssh-agent configurado como automático y iniciado."
            } catch {
                Write-Warning "No se pudo iniciar el servicio ssh-agent. Error: $($_.Exception.Message)"
                return $false
            }
        } else {
            Write-Host "Servicio ssh-agent ya está corriendo."
        }
        return $true
    } else { # Linux o macOS
        if (-not ($env:SSH_AUTH_SOCK)) {
            Write-Host "Iniciando ssh-agent para la sesión actual..."
            $output = (Start-Process -FilePath "ssh-agent" -ArgumentList "-s" -NoNewWindow -PassThru -ErrorAction Stop | Out-String)
            if ($output -match 'SSH_AUTH_SOCK=(.+); export SSH_AUTH_SOCK;') {
                $env:SSH_AUTH_SOCK = $Matches[1]
            }
            if ($output -match 'SSH_AGENT_PID=(.+); export SSH_AGENT_PID;') {
                $env:SSH_AGENT_PID = $Matches[1]
            }
            if (-not ($env:SSH_AUTH_SOCK)) {
                Write-Warning "No se pudo iniciar ssh-agent. Las claves podrían no cargarse automáticamente."
                return $false
            }
            Write-Host "ssh-agent iniciado."
        } else {
            Write-Host "ssh-agent ya está corriendo en la sesión actual."
        }
        return $true
    }
}

function Generate-AndAddSshKey {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Email,
        [Parameter(Mandatory=$true)]
        [string]$KeyPath,
        [Parameter(Mandatory=$true)]
        [string]$KeyComment
    )

    if (Test-Path $KeyPath) {
        Write-Warning "La clave SSH ya existe en '$KeyPath'. Saltando la generación de esta clave."
    } else {
        Write-Host "Generando nueva clave SSH para '$KeyComment' en '$KeyPath'..."
        try {
            ssh-keygen -t ed25519 -C "$Email ($KeyComment)" -f $KeyPath -N "" -ErrorAction Stop | Out-Null
            Write-Host "Clave generada exitosamente."
        } catch {
            Write-Error "Fallo al generar la clave SSH para '$KeyComment'. Error: $($_.Exception.Message)"
            return $false
        }
    }

    Write-Host "Añadiendo clave SSH al agente..."
    try {
        ssh-add $KeyPath -ErrorAction Stop | Out-Null
        Write-Host "Clave añadida al agente SSH."
    } catch {
        Write-Error "Fallo al añadir la clave SSH al agente para '$KeyComment'. Error: $($_.Exception.Message)"
        Write-Warning "Asegúrate de que el agente SSH esté funcionando correctamente."
        return $false
    }
    return $true
}

# --- Lógica Principal ---

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$sshDir = Join-Path (Get-HomeDirectory) ".ssh"
$sshConfigPath = Join-Path $sshDir "config"

Write-Host "Iniciando configuración de claves SSH para Git multi-identidad..."

# 1. Crear directorio .ssh si no existe
if (-not (Test-Path $sshDir)) {
    New-Item -Path $sshDir -ItemType Directory -Force | Out-Null
    Write-Host "Directorio '$sshDir' creado."
} else {
    Write-Host "Directorio '$sshDir' ya existe."
}

# 2. Asegurar que el agente SSH esté corriendo
if (-not (Ensure-SshAgentRunning)) {
    Write-Error "No se pudo asegurar que el agente SSH estuviera corriendo. Las claves podrían no cargarse correctamente."
    exit 1
}

# 3. Leer emails de los archivos .gitconfig
$githubEmail = Get-GitConfigEmail -Path (Join-Path $PSScriptRoot ".gitconfig-personal")
if (-not $githubEmail) {
    Write-Warning "No se pudo obtener el email para GitHub de '.gitconfig-personal'. Usando un email genérico para el comentario de la clave."
    $githubEmail = "user@example.com" # Fallback email
}

$workEmail = Get-GitConfigEmail -Path (Join-Path $PSScriptRoot ".gitconfig-work")
if (-not $workEmail) {
    Write-Warning "No se pudo obtener el email para el trabajo de '.gitconfig-work'. Usando un email genérico para el comentario de la clave."
    $workEmail = "work@example.com" # Fallback email
}

# 4. Generar y añadir claves SSH para GitHub
Write-Host "`n--- Configurando clave SSH para GitHub (Personal/Estudios) ---"
$githubKeyPath = Join-Path $sshDir "id_ed25519_github"
if (Generate-AndAddSshKey -Email $githubEmail -KeyPath $githubKeyPath -KeyComment "GitHub (Personal/Estudios)") {
    # 5. Añadir configuración a ~/.ssh/config para GitHub
    Write-Host "Añadiendo configuración para GitHub a '$sshConfigPath'..."
    $githubConfig = @(
        "`nHost github.com",
        "  HostName github.com",
        "  User git",
        "  IdentityFile $githubKeyPath",
        "  IdentitiesOnly yes"
    )
    $githubConfig | Add-Content -Path $sshConfigPath -Force
    Write-Host "Configuración de GitHub añadida."
}

# 6. Generar y añadir claves SSH para Work (GitLab Enterprise)
Write-Host "`n--- Configurando clave SSH para Work (GitLab Enterprise) ---"
$workKeyPath = Join-Path $sshDir "id_ed25519_work"
$workGitLabHostname = Read-Host "Por favor, introduce el hostname de tu GitLab Enterprise (ej: gitlab.miempresa.com)"
if ([string]::IsNullOrWhiteSpace($workGitLabHostname)) {
    Write-Error "Hostname de GitLab Enterprise no puede estar vacío. Saltando configuración de clave de trabajo."
} else {
    if (Generate-AndAddSshKey -Email $workEmail -KeyPath $workKeyPath -KeyComment "Work (GitLab Enterprise)") {
        # 7. Añadir configuración a ~/.ssh/config para Work
        Write-Host "Añadiendo configuración para Work a '$sshConfigPath'..."
        $workConfig = @(
            "`nHost $workGitLabHostname",
            "  HostName $workGitLabHostname",
            "  User git",
            "  IdentityFile $workKeyPath",
            "  IdentitiesOnly yes"
        )
        $workConfig | Add-Content -Path $sshConfigPath -Force
        Write-Host "Configuración de Work añadida."
    }
}

# --- Finalización e Instrucciones ---

Write-Host "`n--- Configuración SSH Completada ---"
Write-Host "Se han generado y configurado las siguientes claves SSH:"

# Mostrar clave pública de GitHub
$githubPublicKeyPath = "${githubKeyPath}.pub"
if (Test-Path $githubPublicKeyPath) {
    Write-Host "`n--> Clave Pública para GitHub (Personal/Estudios) <--"
    $githubPublicKey = Get-Content -Path $githubPublicKeyPath
    Write-Host $githubPublicKey
    Write-Host "`nPor favor, COPIA esta clave pública y añádela a la configuración de tu ÚNICA cuenta de GitHub (https://github.com/settings/keys)."
} else {
    Write-Warning "No se encontró la clave pública de GitHub en '$githubPublicKeyPath'."
}

# Mostrar clave pública de Work
$workPublicKeyPath = "${workKeyPath}.pub"
if (Test-Path $workPublicKeyPath) {
    Write-Host "`n--> Clave Pública para Work (GitLab Enterprise) <--"
    $workPublicKey = Get-Content -Path $workPublicKeyPath
    Write-Host $workPublicKey
    Write-Host "`nPor favor, COPIA esta clave pública y añádela a tu perfil de GitLab Enterprise (en '$workGitLabHostname')."
} else {
    Write-Warning "No se encontró la clave pública de Work en '$workPublicKeyPath'."
}

Write-Host "`n--- Cómo Clonar Repositorios ---"
Write-Host "1. Para CUALQUIER repositorio de GitHub (personal o de estudios):"
Write-Host "   git clone git@github.com:tu-usuario/tu-repo.git"
Write-Host "2. Para CUALQUIER repositorio de tu GitLab Enterprise:"
Write-Host "   git clone git@$workGitLabHostname:tu-grupo/tu-proyecto.git"

Write-Host "`n¡Configuración SSH completada!"
