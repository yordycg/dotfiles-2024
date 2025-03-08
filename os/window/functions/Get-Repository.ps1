function Get-Repository{
    param (
        [Parameter(Mandatory=$true)]
        [string]$RepoName,
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath,
        [switch]$Recursive
    )
    $RepoUrl = "https://github.com/yordycg/$RepoName"

    try {
        if (Test-Path -Path $DestinationPath) {
            Write-Host "Advertencia: El directorio de destino '$DestinationPath' ya existe." -ForegroundColor Yellow
            return
        }

        Write-Host "Clonando el repositorio '$RepoUrl' en '$DestinationPath'..." -ForegroundColor Cyan

        if ($Recursive) {
            git clone --recursive $RepoUrl $DestinationPath
        } else {
            git clone $RepoUrl $DestinationPath
        }

        Write-Host "Repositorio clonado." -ForegroundColor Green
    } catch {
        Write-Error "Error al clonar el repositorio: $($_.Exception.Message)"
    }
}