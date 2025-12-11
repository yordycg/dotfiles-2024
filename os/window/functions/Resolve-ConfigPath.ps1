function Resolve-ConfigPath {
    param (
        [string]$Path,
        [hashtable]$ConfigPaths
    )

    # Regex para encontrar placeholders del tipo %algo%
    $regex = '%(.*?)%'

    # Mientras haya coincidencias en el Path
    while ($Path -match $regex) {
        $placeholder = $matches[1]

        # Verificar si la clave existe en el hashtable (case-insensitive)
        if ($ConfigPaths.ContainsKey($placeholder)) {
            # --- AQUÍ ESTABA EL ERROR ---
            # Antes: $resolvedBase = Resolve-Path -Path ...
            # Ahora: Llamamos a la función correcta recursivamente
            $resolvedBase = Resolve-ConfigPath -Path $ConfigPaths[$placeholder] -ConfigPaths $ConfigPaths

            # Reemplazar el placeholder por su valor resuelto
            $Path = $Path.Replace("%$placeholder%", $resolvedBase)
        }
        else {
            # Si es una variable de entorno de Windows (ej: %USERNAME%), dejar que el sistema la expanda
            $envVal = [System.Environment]::GetEnvironmentVariable($placeholder)
            if ($null -ne $envVal) {
                $Path = $Path.Replace("%$placeholder%", $envVal)
            }
            else {
                throw "No se pudo resolver el placeholder '%$placeholder%' en la ruta: $Path"
            }
        }
    }

    # Normalizar separadores de ruta
    return $Path.Replace('/', '\')
}