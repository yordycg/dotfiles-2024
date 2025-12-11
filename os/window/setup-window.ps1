# 1. Boilerplate: Verificar y solicitar privilegios de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "El script necesita privilegios de administrador. Reiniciando..."
    Start-Process -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# 2. Iniciar registro de actividad
$LogPath = Join-Path -Path $PSScriptRoot -ChildPath "install-log.txt"
Start-Transcript -Path $LogPath -Append
Write-Host "Ejecutando script como administrador. Registro de actividad iniciado en '$LogPath'."

# 3. Cargar funciones y configuración
Write-Host "Cargando configuración y funciones..."
try {
    $config = Get-Content -Raw -Path (Join-Path -Path $PSScriptRoot -ChildPath "config\config.json") | ConvertFrom-Json

    if ($config.paths -is [System.Management.Automation.PSCustomObject]) {
        $pathsHashTable = @{}
        $config.paths.PSObject.Properties | ForEach-Object {
            $pathsHashTable[$_.Name] = $_.Value
        }

        # Inyectamos valores reales para romper el ciclo infinito de %USERPROFILE%
        if ($pathsHashTable.ContainsKey("userprofile")) {
            $pathsHashTable["userprofile"] = $env:USERPROFILE
        }
        if ($pathsHashTable.ContainsKey("localappdata")) {
            $pathsHashTable["localappdata"] = $env:LOCALAPPDATA
        }

        $config.paths = $pathsHashTable
    }

    # Cargar funciones auxiliares
    Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath "functions") -Filter *.ps1 | ForEach-Object { . $_.FullName }
}
catch {
    Write-Error "Error fatal: No se pudo cargar la configuración o las funciones. Razón: $($_.Exception.Message)"
    Stop-Transcript
    exit 1
}

# 4. Resolver todas las rutas desde la configuración
Write-Host "Resolviendo rutas de configuración..."
$resolvedPaths = @{}

# Usamos un bucle foreach directo sobre las Keys
foreach ($key in $config.paths.Keys) {
    $val = $config.paths[$key]
    # CAMBIO IMPORTANTE: Usamos la nueva función Resolve-ConfigPath
    $resolvedPaths[$key] = Resolve-ConfigPath -Path $val -ConfigPaths $config.paths
}

# 5. Crear directorios
Write-Host "Creando directorios definidos en la configuración..."
foreach ($dir in $config.directoriesToCreate) {
    # CAMBIO IMPORTANTE: Usamos la nueva función Resolve-ConfigPath
    $resolvedDir = Resolve-ConfigPath -Path $dir -ConfigPaths $resolvedPaths
    New-Directory -Path $resolvedDir -Force
}

# 6. Instalar y actualizar Scoop y aplicaciones
Write-Host "Instalando y actualizando Scoop y aplicaciones..."
Install-Scoop

# Refrescar variables de entorno para que reconozca el comando 'scoop' inmediatamente
Write-Host "Refrescando variables de entorno..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "Machine")

Install-ScoopAps -Apps $config.scoopApps

# 6.5. Configurar claves SSH para Git
Write-Host "Ejecutando script de configuración de claves SSH para Git..."
try {
    $sshScriptPath = Join-Path $PSScriptRoot '..\..\git\setup-git-ssh.ps1'

    if (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe") {
        $env:GIT_EMAIL_PERSONAL = $config.emails.personal
        $env:GIT_EMAIL_WORK = $config.emails.work

        & "C:\Program Files\PowerShell\7\pwsh.exe" -Command {
            param($ScriptPath)
            # Dentro de PWSH 7, reconstruimos un objeto config básico
            $Config = @{ emails = @{ personal = $env:GIT_EMAIL_PERSONAL; work = $env:GIT_EMAIL_WORK } }
            . $ScriptPath -Config $Config
        } -Args $sshScriptPath

        # Limpiar variables
        Remove-Item Env:\GIT_EMAIL_PERSONAL
        Remove-Item Env:\GIT_EMAIL_WORK
    }
    else {
        Write-Warning "PowerShell 7 (pwsh) no encontrado. Saltando SSH setup avanzado."
    }

}
catch {
    Write-Warning "El script de configuración de SSH falló o no se pudo invocar. Error: $($_.Exception.Message)"
}

# 7. Clonar y actualizar repositorios
Write-Host "Clonando y actualizando repositorios..."
foreach ($repo in $config.repositories) {
    $destination = Resolve-ConfigPath -Path $repo.destination -ConfigPaths $resolvedPaths
    Sync-Repository -RepoName $repo.name -DestinationPath $destination
}

# 8. Crear enlaces simbólicos
Write-Host "Creando enlaces simbólicos..."
foreach ($symlink in $config.symlinks) {
    $target = Resolve-ConfigPath -Path $symlink.target -ConfigPaths $resolvedPaths
    $link = Resolve-ConfigPath -Path $symlink.link -ConfigPaths $resolvedPaths
    New-Symlink -TargetPath $target -LinkPath $link -Force
}

# 9. Configurar perfil de PowerShell
Write-Host "Configurando perfil de PowerShell..."
$profileLine = Resolve-ConfigPath -Path $config.powershellProfileLine -ConfigPaths $resolvedPaths
Set-PowerShellProfile -ProfileContent $profileLine

# 10. Finalizar
Write-Host "Proceso completado."
Stop-Transcript
Write-Host "Registro de actividad guardado en '$LogPath'."