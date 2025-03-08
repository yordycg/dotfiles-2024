function New-Directory {
  param(
    [Parameter(Mandatory=$true)]
    [string]$Path,
    [switch]$Force
  )

  try {
    # Verificar que el directorio no este creado
    if (-not (Test-Path -Path $Path)) {
      New-Item -ItemType Directory -Path $Path -Force:$Force | Out-Null
      Write-Host  "Directorio '$Path' creado." -ForegroundColor Cyan
    } else {
      Write-Host  "El Directorio '$Path' ya existe." -ForegroundColor Cyan
    }
  }
  catch {
    Write-Error "Error al crear el directorio '$Path': $($_Exception.Message)."
  }
}