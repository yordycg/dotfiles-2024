# ----------------------------------------------------------------------
# Windows Work Authentication & SSH Setup (Optional)
# ----------------------------------------------------------------------
# Este script gestiona la configuracion de llaves SSH para entornos
# laborales (GitLab, Bitbucket, etc.) de forma manual e idempotente.
# ----------------------------------------------------------------------

param (
    [string]$Hostname = "gitlab.innevo.cl",
    [string]$Email = "work@example.com",
    [string]$KeyName = "id_ed25519_work"
)

# --- Funciones de Utilidad ---
function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Cyan }
function Write-Success { param($Msg) Write-Host "[OK]   $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }

Write-Host "=== Configurando Entorno de Trabajo: $Hostname ===" -ForegroundColor Blue

# 1. Preparar Directorio SSH
$sshDir = Join-Path $env:USERPROFILE ".ssh"
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
}

# 2. Generar Llave SSH (Idempotente)
$keyPath = Join-Path $sshDir $KeyName
$pubKeyPath = "$keyPath.pub"
$computerName = $env:COMPUTERNAME.ToLower()
$keyComment = "$Email-work-$computerName"

if (Test-Path $keyPath) {
    Write-Success "La llave de trabajo '$KeyName' ya existe. Se reutilizara."
} else {
    Write-Info "Generando nueva llave ed25519 para trabajo..."
    ssh-keygen -t ed25519 -f $keyPath -N '""' -C "$keyComment" -q
    Write-Success "Llave de trabajo generada en $keyPath"
    Write-Warn "RECUERDA: Debes subir manualmente el contenido de '$pubKeyPath' a tu servidor $Hostname."
}

# 3. Configurar/Iniciar ssh-agent Service
$agentService = Get-Service -Name ssh-agent -ErrorAction SilentlyContinue
if ($null -ne $agentService -and $agentService.Status -eq "Running") {
    ssh-add $keyPath 2>&1 | Out-Null
    Write-Success "Llave de trabajo cargada en el agente SSH."
}

# 4. Configurar ~/.ssh/config (Con Marcadores)
$configFile = Join-Path $sshDir "config"
$markerBegin = "# BEGIN $Hostname block (dotfiles-work)"
$markerEnd = "# END $Hostname block (dotfiles-work)"

$configBlock = @"

$markerBegin
Host $Hostname
    HostName $Hostname
    User git
    IdentityFile $keyPath.Replace('\', '/')
    IdentitiesOnly yes
$markerEnd
"@

if (Test-Path $configFile) {
    $content = Get-Content $configFile -Raw
    if ($content -match [regex]::Escape($markerBegin)) {
        Write-Success "La configuracion para $Hostname ya existe en $configFile."
    } else {
        Add-Content -Path $configFile -Value $configBlock
        Write-Success "Configuracion para $Hostname añadida."
    }
} else {
    Set-Content -Path $configFile -Value $configBlock
    Write-Success "Archivo config creado con el bloque para $Hostname."
}

Write-Host "--- Setup de Trabajo Finalizado ---`n" -ForegroundColor Green
