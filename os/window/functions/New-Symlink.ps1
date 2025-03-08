function New-Symlink {
  param(
    [Parameter(Mandatory=$true)]
    [string]$TargetPath,
    [Parameter(Mandatory=$true)]
    [string]$LinkPath,
    [switch]$Force
  )

  try {
     # Verificar si el enlace ya existe
        if (Test-Path -Path $LinkPath) {
            # Si el enlace existe y se especifica -Force, eliminarlo
            if ($Force) {
                Remove-Item -Path $LinkPath -Force
                Write-Host "Enlace existente '$LinkPath' eliminado." -ForegroundColor Red
            } else {
                Write-Host "Advertencia: El enlace '$LinkPath' ya existe. Use -Force para sobrescribir." -ForegroundColor Yellow
                return
            }
        }

        # Crear el enlace simbólico
        New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath -Force:$Force | Out-Null

        Write-Host "Enlace simbólico creado: '$LinkPath' -> '$TargetPath'." -ForegroundColor Green
  }
  catch {
    Write-Error "Error al crear el enlace simbólico: $($_.Exception.Message)"
  }
}

# Crear un enlace simbólico a un archivo
# New-Symlink -TargetPath "C:\Ruta\al\archivo.txt" -LinkPath "C:\Ruta\al\enlace.txt"
# Crear un enlace simbólico a un directorio
# New-Symlink -TargetPath "C:\Ruta\al\directorio" -LinkPath "C:\Ruta\al\enlace_directorio"
# Sobrescribir un enlace existente
# New-Symlink -TargetPath "C:\Ruta\al\nuevo_archivo.txt" -LinkPath "C:\Ruta\al\enlace.txt" -Force