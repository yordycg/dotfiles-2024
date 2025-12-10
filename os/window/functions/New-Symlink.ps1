function New-Symlink {
  param(
    [Parameter(Mandatory=$true)] [string]$TargetPath,
    [Parameter(Mandatory=$true)] [string]$LinkPath,
    [switch]$Force
  )

  try {
    # Comprueba si existe algo en la ruta del enlace
    if (Test-Path -Path $LinkPath) {
      $existingItem = Get-Item -Path $LinkPath -Force
      # Comprueba si lo que existe es un enlace simbólico
      if ($existingItem.LinkType -eq 'SymbolicLink') {
        if ($Force) {
          Write-Host "Eliminando enlace simbólico existente en '$LinkPath'." -ForegroundColor Yellow
          Remove-Item -Path $LinkPath -Force
        } else {
          Write-Host "El enlace '$LinkPath' ya existe. Usa -Force para reemplazarlo." -ForegroundColor Yellow
          return # No hagas nada si ya existe y no se fuerza
        }
      } else {
        # Si no es un enlace, es un archivo o directorio real.
        if ($Force) {
            Write-Warning "Se encontró un archivo o directorio real en '$LinkPath'. Se eliminará para crear el enlace."
            Remove-Item -Path $LinkPath -Recurse -Force
        } else {
            Write-Error "Error: Ya existe un archivo o directorio en '$LinkPath' que no es un enlace. Usa -Force para reemplazarlo."
            return
        }
      }
    }

    # Asegurarse de que el directorio padre del enlace exista
    $parentDir = Split-Path -Path $LinkPath -Parent
    if (-not (Test-Path -Path $parentDir)) {
      New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    # Crear el enlace
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath | Out-Null
    Write-Host "Enlace creado: '$LinkPath' -> '$TargetPath'." -ForegroundColor Green
  }
  catch {
    Write-Error "Ocurrió un error inesperado con '$LinkPath': $($_.Exception.Message)"
  }
}
