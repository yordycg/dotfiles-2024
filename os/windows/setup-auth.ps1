# ----------------------------------------------------------------------
# Windows Authentication & SSH Setup
# ----------------------------------------------------------------------
# Este script gestiona la autenticacion con GitHub y la configuracion
# de llaves SSH de forma idempotente.
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
    gh auth login --hostname github.com --scopes "admin:public_key" --web
    if ($LASTEXITCODE -ne 0) { Write-Die "Fallo la autenticacion con GitHub CLI." }
}
Write-Success "GitHub CLI autenticado."

# 3. Preparar Directorio SSH
$sshDir = Join-Path $env:USERPROFILE ".ssh"
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
    Write-Info "Directorio .ssh creado."
}

# 4. Generar Llave SSH (Idempotente)
$keyName = "id_ed25519_github"
$keyPath = Join-Path $sshDir $keyName
$pubKeyPath = "$keyPath.pub"
$hostname = $env:COMPUTERNAME.ToLower()
$keyComment = "github-windows-$hostname"
$keyTitle = "Windows Key ($hostname)"

if (Test-Path $keyPath) {
    Write-Success "La llave SSH '$keyName' ya existe. Se reutilizara."
} else {
    Write-Info "Generando nueva llave ed25519..."
    ssh-keygen -t ed25519 -f $keyPath -N '""' -C "$keyComment" -q
    Write-Success "Llave generada en $keyPath"
}

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
        # Agregar la llave al agente
        ssh-add $keyPath 2>&1 | Out-Null
        Write-Success "Agente SSH activo y llave cargada."
    } catch {
        Write-Warn "No se pudo configurar el agente automaticamente: $($_.Exception.Message)"
    }
}

# 6. Sincronizar Llave con GitHub
Write-Info "Sincronizando llave publica con GitHub..."
$existingKeys = gh ssh-key list | Out-String
if ($existingKeys -match [regex]::Escape($keyTitle)) {
    Write-Success "La llave ya esta registrada en GitHub."
} else {
    gh ssh-key add $pubKeyPath --title "$keyTitle"
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Llave subida a GitHub correctamente."
    } else {
        Write-Warn "No se pudo subir la llave. Es posible que ya exista con otro nombre o el token no tenga permisos."
    }
}

# 7. Configurar ~/.ssh/config (Con Marcadores)
$configFile = Join-Path $sshDir "config"
$markerBegin = "# BEGIN github.com block (dotfiles-windows)"
$markerEnd = "# END github.com block (dotfiles-windows)"

$configBlock = @"

$markerBegin
Host github.com
    HostName github.com
    User git
    IdentityFile $keyPath.Replace('\', '/')
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

Write-Host "`n--- Setup de Autenticacion Finalizado ---" -ForegroundColor Green
