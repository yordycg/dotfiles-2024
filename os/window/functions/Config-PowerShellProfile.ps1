function Configure-PowerShellProfile {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProfileContent,

        [string]$ProfilePath = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    )

    try {
        # Verificar si el directorio existe y crearlo si no
        if (-not (Test-Path -Path (Split-Path -Path $ProfilePath))) {
            New-Item -ItemType Directory -Path (Split-Path -Path $ProfilePath) -Force | Out-Null
            Write-Host "Directorio del perfil de PowerShell creado."
        }

        # Verificar si el perfil ya existe
        if (Test-Path -Path $ProfilePath) {
            # Verificar si la línea ya existe
            if (-not (Get-Content -Path $ProfilePath | Where-Object { $_ -eq $ProfileContent })) {
                # Agregar la línea al final del archivo
                Add-Content -Path $ProfilePath -Value $ProfileContent
                Write-Host "Línea agregada al perfil de PowerShell."
            } else {
                Write-Host "La línea ya existe en el perfil de PowerShell."
            }
        } else {
            # Crear el archivo de perfil con la línea
            New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
            Add-Content -Path $ProfilePath -Value $ProfileContent
            Write-Host "Perfil de PowerShell creado."
        }
    } catch {
        Write-Error "Error al configurar el perfil de PowerShell: $($_.Exception.Message)"
    }
}