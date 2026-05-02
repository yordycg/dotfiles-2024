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
            if ($existingItem.LinkType -eq 'SymbolicLink') {
                if ($Force) {
                    Write-Host "Eliminando enlace simbólico existente en '$LinkPath'." -ForegroundColor Yellow
                    Remove-Item -Path $LinkPath -Force
                } else {
                    Write-Host "El enlace '$LinkPath' ya existe. Usa -Force para reemplazarlo." -ForegroundColor Yellow
                    return
                }
            } else {
                if ($Force) {
                    Write-Warning "Se encontró un archivo o directorio real en '$LinkPath'. Se eliminará para crear el enlace."
                    Remove-Item -Path $LinkPath -Recurse -Force
                } else {
                    Write-Error "Error: Ya existe un archivo o directorio en '$LinkPath' que no es un enlace. Usa -Force para reemplazarlo."
                    return
                }
            }
        }

        $parentDir = Split-Path -Path $LinkPath -Parent
        if (-not (Test-Path -Path $parentDir)) {
            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        }

        New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath | Out-Null
        Write-Host "Enlace creado: '$LinkPath' -> '$TargetPath'." -ForegroundColor Green
    }
    catch {
        Write-Error "Ocurrió un error inesperado con '$LinkPath': $($_.Exception.Message)"
    }
}

function New-Directory {
    param(
        [Parameter(Mandatory=$true)] [string]$Path,
        [switch]$Force
    )

    try {
        if (-not (Test-Path -Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force:$Force | Out-Null
            Write-Host "Directorio '$Path' creado." -ForegroundColor Cyan
        } else {
            Write-Host "El directorio '$Path' ya existe." -ForegroundColor Gray
        }
    }
    catch {
        Write-Error "Error al crear el directorio '$Path': $($_.Exception.Message)."
    }
}

function Install-Scoop {
    $ScoopPath = "$env:USERPROFILE\scoop\shims\scoop.ps1"
    try {
        if (Test-Path $ScoopPath) {
            Write-Host "Scoop ya está instalado. Actualizando..." -ForegroundColor Cyan
            & scoop update
        } else {
            Write-Host "Instalando Scoop..." -ForegroundColor Cyan
            iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
            Write-Host "Agregando buckets..." -ForegroundColor Cyan
            & scoop bucket add extras
            & scoop bucket add nerd-fonts
            & scoop bucket add versions
        }
    }
    catch {
        Write-Error "Error al instalar/actualizar Scoop: $($_.Exception.Message)."
    }
}

function Install-ScoopApps {
    param(
        [string[]]$Apps
    )

    if (-not $Apps) {
        Write-Warning "No se especificaron aplicaciones para instalar."
        return
    }

    foreach ($app in $Apps) {
        try {
            $status = scoop status $app | Out-String
            if ($status -like '*OK*') {
                Write-Host "$app ya está instalado." -ForegroundColor Gray
            } else {
                Write-Host "Instalando/Actualizando $app..." -ForegroundColor Cyan
                & scoop install $app
            }
        }
        catch {
            Write-Error "No se pudo instalar '$app'. Razón: $($_.Exception.Message)"
        }
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

        if (Test-Path $ProfilePath) {
            if (-not (Get-Content $ProfilePath | Where-Object { $_ -eq $ProfileContent })) {
                Add-Content -Path $ProfilePath -Value "`n$ProfileContent"
                Write-Host "Perfil actualizado con: $ProfileContent" -ForegroundColor Green
            } else {
                Write-Host "El perfil ya contiene la configuración." -ForegroundColor Gray
            }
        } else {
            Set-Content -Path $ProfilePath -Value $ProfileContent
            Write-Host "Perfil de PowerShell creado." -ForegroundColor Green
        }
    } catch {
        Write-Error "Error al configurar perfil: $($_.Exception.Message)"
    }
}

Export-ModuleMember -Function Resolve-ConfigPath, New-Symlink, New-Directory, Install-Scoop, Install-ScoopApps, Sync-Repository, Set-PowerShellProfile
