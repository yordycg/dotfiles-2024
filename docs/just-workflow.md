# Just: Orquestación de Tareas Senior

Este repositorio utiliza **`Just`** como herramienta estándar para la ejecución de tareas. El objetivo es eliminar la necesidad de recordar rutas de scripts o flags complejos, centralizando todo en un único punto de entrada.

## ¿Por qué Just?
1. **Descubribilidad**: Escribe `just` en cualquier proyecto y verás qué puedes hacer.
2. **Abstracción**: No importa si el proyecto es Python, JS o C++, siempre usarás `just dev` o `just build`.
3. **Legibilidad**: Los comandos están agrupados y documentados.

## Uso en Dotfiles
En la raíz de este repositorio, puedes ejecutar:

- `just update`: Actualiza el sistema (`yay`) y sincroniza tus listas de paquetes en el acto.
- `just font`: Lanza el selector de fuentes interactivo.
- `just theme`: Lanza el selector de temas global.
- `just links`: Refresca todos los enlaces simbólicos de tu configuración.
## Uso en Proyectos Personales
Para cada nuevo proyecto que crees, se recomienda crear un `Justfile` local. Un ejemplo estándar sería:

```just
# Justfile template
dev:
    python manage.py runserver

migrate:
    python manage.py migrate

shell:
    python manage.py shell_plus
```

## Just en Windows
`Just` es la herramienta perfecta para unificar tu experiencia en Windows y Linux.

### Instalación en Windows
Se recomienda usar **Scoop** para una instalación rápida:
```powershell
scoop install just
```

### Justfiles Multi-plataforma
Puedes escribir tareas que detecten automáticamente el sistema operativo. Ejemplo para un entorno virtual de Python:

```just
# Detectar binario de python según el OS
python := if os() == "windows" { ".venv/Scripts/python.exe" } else { ".venv/bin/python" }

dev:
    {{python}} manage.py runserver
```

Esto te permite usar el mismo comando `just dev` tanto en tu Arch Linux como en tu partición de Windows sin cambiar ni una letra.

## Beneficios a largo plazo
...
Al adoptar este flujo, tu cerebro queda libre para enfocarse en la lógica del código, dejando que `Just` maneje la "fontanería" de los comandos de sistema.
