# Script de instalación y configuración de WSL
# Autor: Claude
# Fecha: 7 de marzo 2025
# Descripción: Este script instala WSL2, configura una distribución Linux y prepara el entorno de desarrollo para C++

# Función para verificar si el script se está ejecutando como administrador
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    $principal = New-Object Security.Principal.WindowsPrincipal $user;
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Verificar si se está ejecutando como administrador
if (-not (Test-Administrator)) {
    Write-Error "Este script necesita ejecutarse como administrador. Por favor, reinicia PowerShell como administrador."
    exit
}

# Función para verificar si un comando existe
function Test-CommandExists {
    param($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try { if (Get-Command $command) { return $true } }
    catch { return $false }
    finally { $ErrorActionPreference = $oldPreference }
}

# Configuración de variables
$distro = "Ubuntu-22.04"  # Puedes cambiar a otra distribución si prefieres
$username = "usuario"     # Cambia al nombre de usuario que deseas usar en Linux
$password = "password"    # Cambia a una contraseña segura

# Función para mostrar un menú de opciones
function Show-Menu {
    Clear-Host
    Write-Host "===== Gestor de WSL para desarrollo C++ =====" -ForegroundColor Cyan
    Write-Host "1. Instalar WSL2 y $distro"
    Write-Host "2. Configurar entorno de desarrollo C++ en WSL"
    Write-Host "3. Configurar integración de VSCode con WSL"
    Write-Host "4. Configurar integración de CLion con WSL"
    Write-Host "5. Crear accesos directos para WSL"
    Write-Host "6. Reiniciar/Resetear WSL"
    Write-Host "7. Hacer backup de WSL"
    Write-Host "8. Restaurar backup de WSL"
    Write-Host "9. Salir"
    Write-Host "=============================================" -ForegroundColor Cyan
}

# 1. Instalar WSL2 y la distribución seleccionada
function Install-WSL {
    Write-Host "Instalando WSL2 y $distro..." -ForegroundColor Green

    # Habilitar características de Windows necesarias
    Write-Host "Habilitando características de Windows requeridas..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    
    # Establecer WSL2 como versión predeterminada
    Write-Host "Configurando WSL2 como versión predeterminada..."
    wsl --set-default-version 2
    
    # Instalar la distribución
    Write-Host "Instalando $distro... (Esto puede tardar unos minutos)"
    wsl --install -d $distro
    
    # Esperar a que la instalación se complete
    Start-Sleep -Seconds 10
    
    # Configurar usuario y contraseña automáticamente (esto requiere que la distribución esté recién instalada)
    if ((wsl -l -v) -match $distro) {
        Write-Host "Distribución instalada. Configurando usuario $username..."
        wsl -d $distro -u root useradd -m -G sudo $username
        wsl -d $distro -u root bash -c "echo '$username:$password' | chpasswd"
        wsl -d $distro -u root chsh -s /bin/bash $username
        wsl --set-default-user $distro $username
    } else {
        Write-Host "No se pudo instalar la distribución. Intenta instalarla manualmente desde la Microsoft Store." -ForegroundColor Red
    }
    
    Write-Host "Instalación de WSL2 y $distro completada. Se recomienda reiniciar el sistema." -ForegroundColor Green
}

# 2. Configurar entorno de desarrollo C++ en WSL
function Configure-CppEnvironment {
    Write-Host "Configurando entorno de desarrollo C++ en WSL..." -ForegroundColor Green
    
    # Actualizar los repositorios e instalar paquetes esenciales
    wsl -d $distro -u $username bash -c "sudo apt update && sudo apt upgrade -y"
    wsl -d $distro -u $username bash -c "sudo apt install -y build-essential gdb cmake ninja-build git curl zip unzip tar pkg-config libssl-dev"
    
    # Instalar compiladores adicionales (Clang/LLVM)
    wsl -d $distro -u $username bash -c "sudo apt install -y clang clang-format clang-tidy llvm lldb lld"
    
    # Instalar herramientas de análisis y depuración
    wsl -d $distro -u $username bash -c "sudo apt install -y valgrind cppcheck"
    
    # Instalar vcpkg (gestor de paquetes C++)
    wsl -d $distro -u $username bash -c "git clone https://github.com/Microsoft/vcpkg.git ~/vcpkg && ~/vcpkg/bootstrap-vcpkg.sh"
    
    # Configurar .bashrc con variables de entorno útiles
    wsl -d $distro -u $username bash -c "echo 'export PATH=\$PATH:\$HOME/vcpkg' >> ~/.bashrc"
    wsl -d $distro -u $username bash -c "echo 'export VCPKG_ROOT=\$HOME/vcpkg' >> ~/.bashrc"
    
    Write-Host "Entorno de desarrollo C++ configurado correctamente en WSL." -ForegroundColor Green
}

# 3. Configurar integración de VSCode con WSL
function Configure-VSCodeIntegration {
    Write-Host "Configurando integración de VSCode con WSL..." -ForegroundColor Green
    
    # Verificar si VSCode está instalado
    if (-not (Test-CommandExists code)) {
        Write-Host "VSCode no está instalado o no está en el PATH. Instalando VSCode..." -ForegroundColor Yellow
        # Instalar VSCode si no está presente
        if (Test-CommandExists scoop) {
            scoop install vscode
        } else {
            $vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
            $outputPath = "$env:TEMP\vscode_installer.exe"
            Invoke-WebRequest -Uri $vscodeUrl -OutFile $outputPath
            Start-Process -FilePath $outputPath -ArgumentList "/SILENT /NORESTART" -Wait
            Remove-Item $outputPath
        }
    }
    
    # Instalar extensión de WSL para VSCode
    Write-Host "Instalando extensión WSL para VSCode..."
    code --install-extension ms-vscode-remote.remote-wsl
    
    # Instalar extensiones útiles para C++ en VSCode
    Write-Host "Instalando extensiones útiles para desarrollo C++..."
    code --install-extension ms-vscode.cpptools
    code --install-extension ms-vscode.cmake-tools
    code --install-extension llvm-vs-code-extensions.vscode-clangd
    code --install-extension ms-vscode.makefile-tools
    
    # Crear archivo de configuración para C++ en WSL
    $settingsFolder = "$env:APPDATA\Code\User"
    $settingsFile = "$settingsFolder\settings.json"
    
    if (-not (Test-Path $settingsFolder)) {
        New-Item -ItemType Directory -Path $settingsFolder -Force | Out-Null
    }
    
    $vscodeSettings = @{
        "remote.WSL.defaultDistro" = $distro
        "C_Cpp.default.intelliSenseMode" = "linux-gcc-x64"
        "C_Cpp.default.compilerPath" = "/usr/bin/g++"
        "cmake.configureOnOpen" = $true
        "editor.formatOnSave" = $true
        "C_Cpp.clang_format_fallbackStyle" = "Google"
    }
    
    if (Test-Path $settingsFile) {
        $existingSettings = Get-Content -Path $settingsFile -Raw | ConvertFrom-Json
        foreach ($key in $vscodeSettings.Keys) {
            Add-Member -InputObject $existingSettings -NotePropertyName $key -NotePropertyValue $vscodeSettings[$key] -Force
        }
        $existingSettings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsFile
    } else {
        $vscodeSettings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsFile
    }
    
    Write-Host "Integración de VSCode con WSL configurada correctamente." -ForegroundColor Green
}

# 4. Configurar integración de CLion con WSL
function Configure-CLionIntegration {
    Write-Host "Configurando integración de CLion con WSL..." -ForegroundColor Green
    
    # Esta función proporciona instrucciones, ya que la configuración de CLion requiere pasos manuales
    Write-Host "Para configurar CLion con WSL, sigue estos pasos:" -ForegroundColor Yellow
    Write-Host "1. Abre CLion"
    Write-Host "2. Ve a File > Settings > Build, Execution, Deployment > Toolchains"
    Write-Host "3. Haz clic en el botón '+' y selecciona 'WSL'"
    Write-Host "4. Selecciona la distribución $distro de la lista desplegable"
    Write-Host "5. CLion debería detectar automáticamente el compilador, CMake y el depurador"
    Write-Host "6. Haz clic en 'OK' para guardar la configuración"
    Write-Host "7. Al crear un nuevo proyecto, selecciona la cadena de herramientas WSL"
    
    Write-Host "¿Deseas abrir CLion ahora? (S/N)" -ForegroundColor Cyan
    $response = Read-Host
    if ($response -eq "S" -or $response -eq "s") {
        # Intentar encontrar la ubicación de CLion
        $clionPath = "$env:LOCALAPPDATA\JetBrains\Toolbox\apps\CLion\ch-0\*\bin\clion64.exe"
        $clionExe = (Get-ChildItem -Path $clionPath -ErrorAction SilentlyContinue | Select-Object -First 1).FullName
        
        if ($clionExe -and (Test-Path $clionExe)) {
            Start-Process -FilePath $clionExe
        } else {
            Write-Host "No se pudo encontrar CLion. Por favor, ábrelo manualmente." -ForegroundColor Yellow
        }
    }
    
    Write-Host "Instrucciones para integración de CLion con WSL proporcionadas." -ForegroundColor Green
}

# 5. Crear accesos directos para WSL
function Create-WSLShortcuts {
    Write-Host "Creando accesos directos para WSL..." -ForegroundColor Green
    
    # Crear acceso directo en el escritorio para WSL
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $wslShortcut = "$desktopPath\WSL $distro.lnk"
    
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($wslShortcut)
    $Shortcut.TargetPath = "wsl.exe"
    $Shortcut.Arguments = "-d $distro"
    $Shortcut.IconLocation = "%SystemRoot%\System32\wsl.exe,0"
    $Shortcut.Description = "Abrir $distro WSL"
    $Shortcut.WorkingDirectory = "%USERPROFILE%"
    $Shortcut.Save()
    
    # Crear acceso directo para VSCode con WSL
    $vscodeWslShortcut = "$desktopPath\VSCode WSL.lnk"
    
    $Shortcut = $WshShell.CreateShortcut($vscodeWslShortcut)
    $Shortcut.TargetPath = "code.exe"
    $Shortcut.Arguments = "--remote wsl+$distro"
    if (Test-Path "${env:ProgramFiles}\Microsoft VS Code\Code.exe") {
        $Shortcut.IconLocation = "${env:ProgramFiles}\Microsoft VS Code\Code.exe,0"
    } else {
        $Shortcut.IconLocation = "${env:LOCALAPPDATA}\Programs\Microsoft VS Code\Code.exe,0"
    }
    $Shortcut.Description = "Abrir VSCode con WSL $distro"
    $Shortcut.WorkingDirectory = "%USERPROFILE%"
    $Shortcut.Save()
    
    Write-Host "Accesos directos creados en el escritorio." -ForegroundColor Green
}

# 6. Reiniciar/Resetear WSL
function Reset-WSL {
    Write-Host "¿Estás seguro de que deseas reiniciar/resetear WSL? Esto cerrará todas las instancias de WSL." -ForegroundColor Yellow
    Write-Host "1. Reiniciar servicios WSL (mantiene los datos)"
    Write-Host "2. Reiniciar $distro (mantiene los datos)"
    Write-Host "3. Resetear $distro (BORRA TODOS LOS DATOS)"
    Write-Host "4. Cancelar"
    $choice = Read-Host "Elige una opción (1-4)"
    
    switch ($choice) {
        1 {
            Write-Host "Reiniciando servicios WSL..." -ForegroundColor Yellow
            wsl --shutdown
            Start-Process -NoNewWindow -Wait net -ArgumentList "stop LxssManager"
            Start-Process -NoNewWindow -Wait net -ArgumentList "start LxssManager"
            Write-Host "Servicios WSL reiniciados correctamente." -ForegroundColor Green
        }
        2 {
            Write-Host "Reiniciando $distro..." -ForegroundColor Yellow
            wsl --terminate $distro
            Write-Host "$distro reiniciado correctamente." -ForegroundColor Green
        }
        3 {
            Write-Host "ADVERTENCIA: Esto eliminará TODOS los archivos y configuraciones de $distro." -ForegroundColor Red
            $confirm = Read-Host "Escribe 'CONFIRMAR' para continuar o cualquier otra cosa para cancelar"
            if ($confirm -eq "CONFIRMAR") {
                Write-Host "Eliminando $distro..." -ForegroundColor Red
                wsl --unregister $distro
                Write-Host "$distro ha sido eliminado. Puedes reinstalarlo usando la opción 1 del menú principal." -ForegroundColor Yellow
            } else {
                Write-Host "Operación cancelada." -ForegroundColor Green
            }
        }
        4 {
            Write-Host "Operación cancelada." -ForegroundColor Green
        }
        default {
            Write-Host "Opción no válida. Operación cancelada." -ForegroundColor Red
        }
    }
}

# 7. Hacer backup de WSL
function Backup-WSL {
    Write-Host "Creando backup de WSL $distro..." -ForegroundColor Green
    
    # Crear carpeta de backups si no existe
    $backupFolder = "$env:USERPROFILE\WSL_Backups"
    if (-not (Test-Path $backupFolder)) {
        New-Item -ItemType Directory -Path $backupFolder | Out-Null
    }
    
    # Generar nombre de archivo con fecha y hora
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFile = "$backupFolder\${distro}_backup_$timestamp.tar"
    
    # Asegurarse de que la distribución esté detenida
    wsl --terminate $distro
    
    # Crear el archivo de backup
    Write-Host "Exportando $distro a $backupFile... (Esto puede tardar varios minutos)"
    wsl --export $distro $backupFile
    
    if (Test-Path $backupFile) {
        Write-Host "Backup creado correctamente en: $backupFile" -ForegroundColor Green
    } else {
        Write-Host "Error al crear el backup." -ForegroundColor Red
    }
}

# 8. Restaurar backup de WSL
function Restore-WSL {
    Write-Host "Restaurando backup de WSL..." -ForegroundColor Green
    
    # Comprobar si existe la carpeta de backups
    $backupFolder = "$env:USERPROFILE\WSL_Backups"
    if (-not (Test-Path $backupFolder)) {
        Write-Host "No se encontró la carpeta de backups: $backupFolder" -ForegroundColor Red
        return
    }
    
    # Obtener lista de archivos de backup
    $backupFiles = Get-ChildItem -Path $backupFolder -Filter "*.tar" | Sort-Object LastWriteTime -Descending
    
    if ($backupFiles.Count -eq 0) {
        Write-Host "No se encontraron archivos de backup en $backupFolder" -ForegroundColor Red
        return
    }
    
    # Mostrar lista de backups disponibles
    Write-Host "Backups disponibles:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $backupFiles.Count; $i++) {
        Write-Host "$($i+1). $($backupFiles[$i].Name) - $($backupFiles[$i].LastWriteTime)"
    }
    
    # Solicitar selección de backup
    $selection = Read-Host "Selecciona el número del backup a restaurar (1-$($backupFiles.Count))"
    
    if (-not [int]::TryParse($selection, [ref]$null) -or [int]$selection -lt 1 -or [int]$selection -gt $backupFiles.Count) {
        Write-Host "Selección no válida. Operación cancelada." -ForegroundColor Red
        return
    }
    
    $selectedBackup = $backupFiles[[int]$selection-1]
    $backupPath = $selectedBackup.FullName
    
    # Comprobar si la distribución ya existe
    $distroExists = (wsl -l) -match $distro
    
    if ($distroExists) {
        Write-Host "La distribución $distro ya existe. ¿Deseas eliminarla antes de restaurar? (S/N)" -ForegroundColor Yellow
        $confirm = Read-Host
        
        if ($confirm -eq "S" -or $confirm -eq "s") {
            Write-Host "Eliminando $distro existente..." -ForegroundColor Yellow
            wsl --unregister $distro
        } else {
            # Generar un nombre nuevo para la distribución restaurada
            $restoredDistro = "${distro}_restored"
            Write-Host "Restaurando backup como una nueva distribución: $restoredDistro" -ForegroundColor Yellow
            
            # Importar el backup con el nuevo nombre
            Write-Host "Importando backup... (Esto puede tardar varios minutos)"
            wsl --import $restoredDistro "$env:LOCALAPPDATA\$restoredDistro" $backupPath
            
            Write-Host "Backup restaurado como $restoredDistro" -ForegroundColor Green
            return
        }
    }
    
    # Importar el backup
    Write-Host "Importando backup... (Esto puede tardar varios minutos)"
    wsl --import $distro "$env:LOCALAPPDATA\$distro" $backupPath
    
    # Establecer el usuario predeterminado
    wsl -d $distro -u root bash -c "echo '$username:$password' | chpasswd"
    wsl --set-default-user $distro $username
    
    Write-Host "Backup restaurado correctamente." -ForegroundColor Green
}

# Bucle principal
$continue = $true
while ($continue) {
    Show-Menu
    $choice = Read-Host "Ingresa tu opción (1-9)"
    
    switch ($choice) {
        1 { Install-WSL }
        2 { Configure-CppEnvironment }
        3 { Configure-VSCodeIntegration }
        4 { Configure-CLionIntegration }
        5 { Create-WSLShortcuts }
        6 { Reset-WSL }
        7 { Backup-WSL }
        8 { Restore-WSL }
        9 { $continue = $false }
        default { Write-Host "Opción no válida. Por favor, selecciona una opción del 1 al 9." -ForegroundColor Red }
    }
    
    if ($continue) {
        Write-Host "`nPresiona Enter para continuar..." -ForegroundColor Cyan
        Read-Host
    }
}

Write-Host "Gracias por usar el script de configuración de WSL. ¡Feliz desarrollo con C++!" -ForegroundColor Cyan
