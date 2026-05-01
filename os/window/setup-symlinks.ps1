# 1. Boilerplate: Verificar y solicitar privilegios de administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "El script necesita privilegios de administrador. Reiniciando..."
    Start-Process -FilePath powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Write-Host "--- Reparación de Enlaces Simbólicos (Windows) ---" -ForegroundColor Cyan

# 2. Cargar configuración y funciones
$configPath = Join-Path -Path $PSScriptRoot -ChildPath "config\config.json"
if (-not (Test-Path $configPath)) {
    Write-Error "No se encontró el archivo de configuración en $configPath"
    exit 1
}

try {
    $config = Get-Content -Raw -Path $configPath | ConvertFrom-Json

    if ($config.paths -is [System.Management.Automation.PSCustomObject]) {
        $pathsHashTable = @{}
        $config.paths.PSObject.Properties | ForEach-Object {
            $pathsHashTable[$_.Name] = $_.Value
        }

        # Inyectamos valores reales para romper el ciclo infinito de %USERPROFILE%
        if ($pathsHashTable.ContainsKey("userprofile")) { $pathsHashTable["userprofile"] = $env:USERPROFILE }
        if ($pathsHashTable.ContainsKey("localappdata")) { $pathsHashTable["localappdata"] = $env:LOCALAPPDATA }

        $config.paths = $pathsHashTable
    }

    # Cargar funciones auxiliares necesarias
    # Cargamos específicamente Resolve-ConfigPath y New-Symlink
    . (Join-Path -Path $PSScriptRoot -ChildPath "functions\Resolve-ConfigPath.ps1")
    . (Join-Path -Path $PSScriptRoot -ChildPath "functions\New-Symlink.ps1")
}
catch {
    Write-Error "Error al cargar la configuración o funciones: $($_.Exception.Message)"
    exit 1
}

# 3. Resolver rutas base
Write-Host "Resolviendo rutas..."
$resolvedPaths = @{}
foreach ($key in $config.paths.Keys) {
    $val = $config.paths[$key]
    $resolvedPaths[$key] = Resolve-ConfigPath -Path $val -ConfigPaths $config.paths
}

# 4. Crear/Reparar Enlaces Simbólicos
Write-Host "Creando/Reparando enlaces simbólicos definidos en config.json..." -ForegroundColor Yellow
foreach ($symlink in $config.symlinks) {
    $target = Resolve-ConfigPath -Path $symlink.target -ConfigPaths $resolvedPaths
    $link = Resolve-ConfigPath -Path $symlink.link -ConfigPaths $resolvedPaths
    
    # Usamos -Force para asegurar que se sobrescriban los enlaces rotos o archivos existentes
    New-Symlink -TargetPath $target -LinkPath $link -Force
}

Write-Host "`nProceso de symlinks finalizado correctamente." -ForegroundColor Green
