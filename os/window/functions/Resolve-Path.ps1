function Resolve-Path {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [hashtable]$ConfigPaths,
        [int]$MaxRecursion = 10
    )

    if ($MaxRecursion -le 0) {
        throw "Se excedió el límite de recursividad al resolver la ruta: $Path"
    }

    $resolvedPath = $Path
    
    # Regex para encontrar placeholders como %placeholder%
    $regex = [regex]'%([^%]+)%'
    $match = $regex.Match($resolvedPath)

    while ($match.Success) {
        $placeholder = $match.Groups[1].Value.ToLower() # case-insensitive
        $value = ""

        # Buscar el valor en las rutas de la configuración
        if ($ConfigPaths.ContainsKey($placeholder)) {
            # Llamada recursiva para resolver placeholders anidados
            $value = Resolve-Path -Path $ConfigPaths[$placeholder] -ConfigPaths $ConfigPaths -MaxRecursion ($MaxRecursion - 1)
        }
        # Buscar en las variables de entorno si no se encuentra en el config
        elseif (Test-Path "env:$placeholder") {
            $value = Get-Content "env:$placeholder"
        }
        else {
            throw "No se pudo resolver el placeholder '%%$($placeholder)%%' en la ruta: $Path"
        }

        # Reemplazar el placeholder con su valor resuelto
        $resolvedPath = $resolvedPath.Replace($match.Value, $value)
        $match = $regex.Match($resolvedPath)
    }

    return $resolvedPath
}
