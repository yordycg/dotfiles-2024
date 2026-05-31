# ----------------------------------------------------------------------
# Windows Authentication & SSH Setup (SEED MODE)
# ----------------------------------------------------------------------
# Este script NO genera llaves. Valida que existan llaves en ~/.ssh
# (provenientes de tu USB) y las configura correctamente.
# ----------------------------------------------------------------------

param (
    [Parameter(Mandatory=$false)]
    [object]$Config
)

# --- Funciones de Utilidad ---
function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Cyan }
function Write-Success { param($Msg) Write-Host "[OK]   $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }
function Write-Die { param($Msg) Write-Error "[ERROR] $Msg"; exit 1 }

# 1. Verificar Dependencias
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Die "GitHub CLI (gh) no encontrado. Por favor, instala Scoop y las aplicaciones primero."
}

# 2. Autenticacion con GitHub CLI
Write-Info "Verificando autenticacion con GitHub..."
$authState = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Warn "No autenticado. Iniciando login via navegador..."
    gh auth login --hostname github.com --scopes "admin:public_key,admin:ssh_signing_key" --web
    if ($LASTEXITCODE -ne 0) { Write-Die "Fallo la autenticacion con GitHub CLI." }
}
Write-Success "GitHub CLI autenticado."

# 3. Preparar Directorio SSH e Identidad Semilla
$sshDir = Join-Path $env:USERPROFILE ".ssh"
$keyName = "id_ed25519" # Nombre estándar para tu llave semilla
$keyPath = Join-Path $sshDir $keyName
$pubKeyPath = "$keyPath.pub"

if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
    Write-Info "Directorio .ssh creado."
}

# --- BUCLE DE ESPERA PARA LLAVES ---
while (-not (Test-Path $keyPath)) {
    Write-Host "`n[!] ATENCION: No se detecto la llave SSH semilla ($keyName) en $sshDir" -ForegroundColor Red
    Write-Host "[→] Por favor, conecta tu USB y copia tus llaves (id_ed25519 e id_ed25519.pub) a la carpeta .ssh" -ForegroundColor Yellow
    Write-Host "[?] Presiona cualquier tecla para reintentar la validacion..." -ForegroundColor Cyan
    $null = [Console]::ReadKey($true)
}
Write-Success "Llaves detectadas en $sshDir"

# 4. Asegurar Permisos (Indispensable en Windows para OpenSSH)
Write-Info "Asegurando permisos estrictos para las llaves..."
# Desactivar herencia y dar acceso total solo al usuario actual
$user = $env:USERNAME
icacls "$keyPath" /inheritance:r /grant:r "${user}:(R)" | Out-Null
if (Test-Path $pubKeyPath) {
    icacls "$pubKeyPath" /inheritance:r /grant:r "${user}:(R)" | Out-Null
}
Write-Success "Permisos de archivo configurados."

# 5. Configurar/Iniciar ssh-agent Service (Windows)
Write-Info "Configurando servicio ssh-agent..."
$agentService = Get-Service -Name ssh-agent -ErrorAction SilentlyContinue
if ($null -eq $agentService) {
    Write-Warn "El servicio ssh-agent no esta disponible en este sistema."
} else {
    try {
        if ($agentService.Status -ne "Running") {
            Set-Service -Name ssh-agent -StartupType Automatic -ErrorAction Stop
            Start-Service -Name ssh-agent -ErrorAction Stop
        }
        # Limpiar llaves anteriores y agregar la nueva
        ssh-add -D 2>&1 | Out-Null
        ssh-add $keyPath 2>&1 | Out-Null
        Write-Success "Agente SSH activo y llave semilla cargada."
    } catch {
        Write-Warn "No se pudo configurar el agente automaticamente: $($_.Exception.Message)"
    }
}

# 6. Sincronizar Llave con GitHub
Write-Info "Sincronizando llave publica con GitHub..."
$keyTitle = "Seed Key - Windows ($env:COMPUTERNAME)"
$existingKeys = gh ssh-key list | Out-String
if ($existingKeys -match [regex]::Escape($keyTitle)) {
    Write-Success "La llave ya esta registrada en GitHub."
} else {
    if (Test-Path $pubKeyPath) {
        gh ssh-key add $pubKeyPath --title "$keyTitle"
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Llave subida a GitHub correctamente."
        } else {
            Write-Warn "No se pudo subir la llave. Es posible que ya exista con otro nombre."
        }
    } else {
        Write-Warn "No se encontro la llave PUBLICA ($pubKeyPath). Saltando registro en GitHub."
    }
}

# 7. Configurar ~/.ssh/config
$configFile = Join-Path $sshDir "config"
$markerBegin = "# BEGIN github.com block (dotfiles-windows)"
$markerEnd = "# END github.com block (dotfiles-windows)"

$configBlock = @"

$markerBegin
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/$keyName
    IdentitiesOnly yes

Host *
    AddKeysToAgent yes
    IdentitiesOnly yes
$markerEnd
"@

if (Test-Path $configFile) {
    $content = Get-Content $configFile -Raw
    if ($content -match [regex]::Escape($markerBegin)) {
        Write-Success "El bloque de configuracion ya existe en $configFile."
    } else {
        Add-Content -Path $configFile -Value $configBlock
        Write-Success "Configuracion añadida a $configFile."
    }
} else {
    Set-Content -Path $configFile -Value $configBlock
    Write-Success "Archivo $configFile creado con la configuracion."
}

Write-Host "`n--- Setup de Autenticacion Finalizado (Seed Mode) ---" -ForegroundColor Green
