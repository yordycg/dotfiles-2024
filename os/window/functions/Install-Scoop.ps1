function Install-Scoop {
  $ScoopPath = "$env:USERPROFILE\scoop\shims\scoop.ps1"
  try {
    # Verificar si Scoop ya esta instalado, caso contrario instalarlo...
    if (Test-Path $ScoopPath) {
      Write-Host "Scoop ya esta instalado. Actualizando..." -ForegroundColor Cyan
      & scoop update
      Write-Host "Scoop actualizado." -ForegroundColor Green
    } else {
      Write-Host "Instalando Scoop..." -ForegroundColor Cyan
      iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
      Write-Host "Agregando bucket 'extras' a Scoop..." -ForegroundColor Cyan
      & scoop bucket add main extras nerd-fonts versions
      Write-Host "Scoop instalado." -ForegroundColor Green
    }
  }
  catch {
    Write-Error "Error al instalar/actualizar Scoop: $($_.Exception.Message)."
  }
}