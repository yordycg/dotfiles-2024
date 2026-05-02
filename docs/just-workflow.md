# 🛠️ Just Workflow Standards

Este documento define los estándares de nomenclatura para los `Justfile` en nuestros proyectos. El objetivo es que cualquier desarrollador pueda ser productivo inmediatamente usando los mismos comandos universales.

## 🚀 Los 3 Pilares de un Proyecto

### 1. Setup (Preparación)
*Comandos para dejar el proyecto listo para trabajar.*

| Comando | Descripción |
| :--- | :--- |
| `just setup` | **El comando principal.** Ejecuta instalación, configuración de `.env` y preparación de DB. |
| `just install` | Instala o actualiza las dependencias del proyecto (npm, pip, cargo, etc). |
| `just init-env` | Crea el archivo `.env` a partir de un template (`.env.example`). |
| `just clean` | Elimina artefactos de compilación, `node_modules`, y archivos temporales. |

### 2. Dev (Ejecución)
*Comandos para el día a día del desarrollo.*

| Comando | Descripción |
| :--- | :--- |
| `just dev` | **Modo desarrollo.** Levanta la app con "Hot Reload" y logs activos. |
| `just db` | Levanta solo los servicios de infraestructura (Docker Compose, bases de datos). |
| `just start` | Ejecuta la aplicación en modo normal/producción local. |
| `just shell` | Abre una terminal interactiva dentro del contexto del proyecto (REPL). |

### 3. Check (Validación)
*Comandos para asegurar la calidad antes de subir código.*

| Comando | Descripción |
| :--- | :--- |
| `just check` | **Pre-commit check.** Ejecuta `lint` + `test` + `build` para validar todo. |
| `just test` | Ejecuta la suite de pruebas unitarias y de integración. |
| `just lint` | Revisa el estilo de código y aplica correcciones automáticas (Ruff, Prettier, etc). |
| `just build` | Genera los binarios o artefactos finales de producción. |

---

## 💡 Buenas Prácticas Senior

1.  **Documenta cada receta:** Usa comentarios `#` arriba de cada comando para que `just --list` sea útil.
2.  **Usa grupos:** Organiza las recetas con `[group('nombre')]` para una ayuda visual clara.
3.  **Variables por defecto:** Define variables sensibles al sistema operativo para que el Justfile sea portable.
4.  **Silent por defecto:** Usa `@` al inicio de los comandos para no ensuciar la terminal con el eco de los comandos, a menos que sea necesario para depurar.

## 📖 Ejemplo de Justfile Estándar

```just
set shell := ["powershell.exe", "-Command"]

# Setup the project from scratch
setup:
    @just install
    @just init-env
    @just db

# Run the development server
dev:
    @echo "🚀 Starting server..."
    npm run dev

# Run all quality checks
check:
    @just lint
    @just test
```
