function Install-ScoopAps{
  param(
    [string[]]$Apps
  )

  try {
    if (-not $Apps) {
      Write-Warning "No se especificaron aplicaciones para instalar."
      return
    }

    foreach ($$app in $Apps) {
      Write-Host "Instalando $app..." -ForegroundColor Cyan
      & scoop install $app
      Write-Host "$app instalado." -ForegroundColor Green
    }
  }
  catch {
    Write-Error "Error al instalar aplicaciones de Scoop: $($_.Exception.Message)."
  }
}