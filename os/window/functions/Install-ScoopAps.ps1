function Install-ScoopAps{
  param(
    [string[]]$Apps
  )

  if (-not $Apps) {
    Write-Warning "No se especificaron aplicaciones para instalar."
    return
  }

  foreach ($app in $Apps) {
    try {
      # Comprobar si la app ya está instalada
      $status = scoop status $app | Out-String
      if ($status -like '*OK*') {
          Write-Host "$app ya está instalado." -ForegroundColor Gray
      } else {
          Write-Host "Instalando/Actualizando $app..." -ForegroundColor Cyan
          scoop install $app
          Write-Host "$app instalado." -ForegroundColor Green
      }
    }
    catch {
      Write-Error "No se pudo instalar '$app'. Razón: $($_.Exception.Message)"
    }
  }
}
