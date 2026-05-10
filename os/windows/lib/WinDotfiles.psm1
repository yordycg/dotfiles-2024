function Resolve-ConfigPath {
    param (
        [Parameter(Mandatory=$true)] [string]$Path,
        [Parameter(Mandatory=$true)] [hashtable]$ConfigPaths
    )

    $regex = '%(.*?)%'
    while ($Path -match $regex) {
        $placeholder = $matches[1]
        if ($ConfigPaths.ContainsKey($placeholder)) {
            $resolvedBase = Resolve-ConfigPath -Path $ConfigPaths[$placeholder] -ConfigPaths $ConfigPaths
            $Path = $Path.Replace("%$placeholder%", $resolvedBase)
        }
        else {
            $envVal = [System.Environment]::GetEnvironmentVariable($placeholder)
            if ($null -ne $envVal) {
                $Path = $Path.Replace("%$placeholder%", $envVal)
            }
            else {
                throw "No se pudo resolver el placeholder '%$placeholder%' en la ruta: $Path"
            }
        }
    }
    return $Path.Replace('/', '\')
}

function New-Symlink {
    param(
        [Parameter(Mandatory=$true)] [string]$TargetPath,
        [Parameter(Mandatory=$true)] [string]$LinkPath,
        [switch]$Force
    )

    try {
        if (Test-Path -Path $LinkPath) {
            $existingItem = Get-Item -Path $LinkPath -Force
            
            # Si ya es un link, verificar a donde apunta
            if ($existingItem.Attributes -match "ReparsePoint") {
                $currentTarget = $existingItem.Target
                if ($currentTarget -eq $TargetPath) {
                    Write-Host "[OK] Enlace ya correcto: '$LinkPath' -> '$TargetPath'." -ForegroundColor Gray
                    return
                }
                
                if ($Force) {
                    Write-Host "[INFO] Reemplazando enlace viejo en '$LinkPath'..." -ForegroundColor Yellow
                    Remove-Item -Path $LinkPath -Force -ErrorAction Stop
                } else {
                    Write-Warning "El enlace '$LinkPath' ya existe pero apunta a '$currentTarget'. Usa -Force para actualizarlo."
                    return
                }
            } else {
                # Es un archivo o directorio real
                if ($Force) {
                    Write-Warning "[WARN] Se encontro un elemento REAL en '$LinkPath'. Moviendo a backup..."
                    $backupPath = "$LinkPath.bak_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                    Move-Item -Path $LinkPath -Destination $backupPath -Force
                } else {
                    Write-Error "Error: Ya existe un ARCHIVO REAL en '$LinkPath'. Usa -Force para respaldarlo y crear el enlace."
                    return
                }
            }
        }

        $parentDir = Split-Path -Path $LinkPath -Parent
        if (-not (Test-Path -Path $parentDir)) {
            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        }

        New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath -Force -ErrorAction Stop | Out-Null
        Write-Host "[SUCCESS] Enlace creado: '$LinkPath' -> '$TargetPath'." -ForegroundColor Green
    }
    catch {
        Write-Error "[FAIL] Fallo al crear enlace '$LinkPath': $($_.Exception.Message)"
    }
}

function New-Directory {
    param(
        [Parameter(Mandatory=$true)] [string]$Path,
        [switch]$Force
    )

    if (-not (Test-Path -Path $Path)) {
        try {
            New-Item -ItemType Directory -Path $Path -Force:$Force | Out-Null
            Write-Host "[INFO] Directorio '$Path' creado." -ForegroundColor Cyan
        }
        catch {
            Write-Error "[ERROR] Error al crear el directorio '$Path': $($_.Exception.Message)."
        }
    }
}

function Install-Scoop {
    $ScoopPath = "$env:USERPROFILE\scoop\shims\scoop.ps1"
    try {
        if (Test-Path $ScoopPath) {
            Write-Host "[INFO] Scoop ya esta instalado. Sincronizando..." -ForegroundColor Gray
            & scoop update | Out-Null
        } else {
            Write-Host "[INFO] Instalando Scoop..." -ForegroundColor Cyan
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
            Write-Host "[INFO] Agregando buckets esenciales..." -ForegroundColor Cyan
            & scoop bucket add extras
            & scoop bucket add nerd-fonts
            & scoop bucket add versions
        }
    }
    catch {
        Write-Error "[ERROR] Error al instalar/actualizar Scoop: $($_.Exception.Message)."
    }
}

function Install-ScoopApps {
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Apps
    )

    if (-not $Apps -or $Apps.Count -eq 0) { return }

    # Optimizacion: Ver que apps estan instaladas mirando el sistema de archivos
    $scoopAppsDir = Join-Path $env:USERPROFILE "scoop\apps"
    $installedApps = if (Test-Path $scoopAppsDir) { Get-ChildItem $scoopAppsDir | Select-Object -ExpandProperty Name } else { @() }

    # Asegurar aria2 para descargas rapidas
    if ("aria2" -notin $installedApps) {
        Write-Host "[INFO] Instalando aria2 para acelerar descargas..." -ForegroundColor Cyan
        & scoop install aria2
        & scoop config aria2-enabled true
    }

    $appsToInstall = $Apps | Where-Object { $_ -notin $installedApps }

    if ($appsToInstall.Count -gt 0) {
        Write-Host "[INFO] Instalando $($appsToInstall.Count) aplicaciones faltantes..." -ForegroundColor Yellow
        & scoop install $appsToInstall
    } else {
        Write-Host "[OK] Todas las aplicaciones de Scoop estan al dia." -ForegroundColor Gray
    }
}

function Sync-Repository {
    param (
        [Parameter(Mandatory=$true)] [string]$RepoName,
        [Parameter(Mandatory=$true)] [string]$DestinationPath,
        [switch]$Recursive
    )
    $RepoUrl = "https://github.com/yordycg/$RepoName"

    try {
        if (Test-Path -Path (Join-Path -Path $DestinationPath -ChildPath ".git")) {
            Write-Host "Actualizando '$RepoName'..." -ForegroundColor Cyan
            Push-Location -Path $DestinationPath
            git pull
            if ($Recursive) { git submodule update --init --recursive }
            Pop-Location
        }
        else {
            if (Test-Path -Path $DestinationPath) {
                Write-Warning "El directorio '$DestinationPath' no es un repo. Limpiando..."
                Remove-Item -Path $DestinationPath -Recurse -Force
            }
            Write-Host "Clonando '$RepoName'..." -ForegroundColor Cyan
            if ($Recursive) { git clone --recursive $RepoUrl $DestinationPath }
            else { git clone $RepoUrl $DestinationPath }
        }
    }
    catch {
        Write-Error "Error al sincronizar repo '$RepoName': $($_.Exception.Message)"
    }
}

function Set-PowerShellProfile {
    param (
        [Parameter(Mandatory=$true)] [string]$ProfileContent,
        [string]$ProfilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    )

    try {
        $parent = Split-Path $ProfilePath
        if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }

        $content = @()
        if (Test-Path $ProfilePath) {
            $content = Get-Content $ProfilePath | Where-Object { $_ -notmatch 'user_profile\.ps1' -and $_ -notmatch '^\s*$' }
        }
        
        $content += "`n$ProfileContent"
        
        $content | Set-Content -Path $ProfilePath -Force
        Write-Host "Perfil configurado en '$ProfilePath'." -ForegroundColor Green
    } catch {
        Write-Error "Error al configurar perfil: $($_.Exception.Message)"
    }
}

Export-ModuleMember -Function Resolve-ConfigPath, New-Symlink, New-Directory, Install-Scoop, Install-ScoopApps, Sync-Repository, Set-PowerShellProfile
