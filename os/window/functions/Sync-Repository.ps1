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
        if (Test-Path -Path (Join-Path -Path $DestinationPath -ChildPath ".git")) {
            Write-Host "El repositorio en '$DestinationPath' ya existe. Actualizando..." -ForegroundColor Cyan
            # Push-Location y Pop-Location cambian temporalmente el directorio
            Push-Location -Path $DestinationPath
            git pull
            if ($Recursive) {
                git submodule update --init --recursive
            }
            Pop-Location
            Write-Host "Repositorio actualizado." -ForegroundColor Green
        } else {
            if (Test-Path -Path $DestinationPath) {
                Write-Warning "El directorio '$DestinationPath' existe pero no es un repositorio de Git. Se eliminará."
                Remove-Item -Path $DestinationPath -Recurse -Force
            }
            
            Write-Host "Clonando el repositorio '$RepoUrl' en '$DestinationPath'..." -ForegroundColor Cyan

            if ($Recursive) {
                git clone --recursive $RepoUrl $DestinationPath
            } else {
                git clone $RepoUrl $DestinationPath
            }

            Write-Host "Repositorio clonado." -ForegroundColor Green
        }
    } catch {
        Write-Error "Error al clonar o actualizar el repositorio: $($_.Exception.Message)"
    }
}
