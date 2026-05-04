# Estándar de Inicialización de Proyectos (Senior Workflow)

Este documento establece el protocolo estándar para la creación y puesta en marcha de cualquier proyecto dentro del ecosistema de `yordycg`. Sigue una filosofía de **Ingeniería de Calidad desde el Día 0**, priorizando la reproducibilidad, el gobierno del código y la automatización.

---

## 1. Filosofía de Desarrollo
Un Senior Software Engineer no construye productos; construye **sistemas de producción de software**. La prioridad es establecer un entorno donde:
1.  **El éxito sea repetible:** El proyecto debe funcionar igual en cualquier máquina (Docker/Just).
2.  **La calidad sea automática:** El linter y el formateador actúan como guardianes constantes.
3.  **La intención sea clara:** La documentación guía tanto a desarrolladores humanos como a agentes de IA.

---

## 2. El Ciclo de Vida de Inicialización (Las 4 Fases)

### Fase 1: Cimientos y Control de Versiones
El objetivo es establecer el rastreo y la consistencia del entorno de trabajo.
*   **Git Init:** Inicialización del repositorio para control de cambios inmediato.
*   **.gitignore:** Configuración rigurosa para evitar la contaminación del repositorio (archivos de sistema, dependencias, secretos).
*   **.editorconfig:** Definición de estándares de estilo a nivel de IDE (indentación, finales de línea, codificación).

### Fase 2: Reglas y Gobierno del Código
Antes de escribir lógica, se definen las "leyes" que regirán el código.
*   **Linting & Formatting (e.g., Biome, Ruff, ESLint):** Configuración de herramientas de análisis estático. No hay debate sobre el estilo; la herramienta decide.
*   **Contexto de IA (GEMINI.md):** Creación de un archivo de "Memoria de Arquitectura" para que los agentes de IA comprendan las restricciones, principios de diseño y filosofía del proyecto.
*   **README.md:** El contrato social del proyecto. Debe incluir: Descripción, Guía de inicio rápido y Stack tecnológico.

### Fase 3: Arquitectura de Directorios
Organización física del código siguiendo patrones de industria.
*   **src/**: Código fuente puro.
*   **docs/**: Diseño, wireframes, y decisiones de arquitectura (ADRs).
*   **tests/**: (Opcional pero recomendado) Estructura para pruebas unitarias e integración.
*   **assets/**: Recursos estáticos (imágenes, fuentes, datos brutos).

### Fase 4: Infraestructura y Automatización
Abstracción de la complejidad operativa para facilitar el desarrollo.
*   **Contenedorización (Docker):** Creación de un `Dockerfile` y `docker-compose.yml` para aislar el entorno de ejecución.
*   **Orquestación de Tareas (Justfile):** Creación de recetas para comandos comunes (dev, build, lint, format, test). Esto elimina la necesidad de recordar flags complejos de CLI.

---

## 3. Checklist de Validación Senior
Un proyecto no se considera "inicializado" hasta que:
- [ ] `just lint` y `just format` se ejecutan sin errores.
- [ ] El entorno de desarrollo levanta con un solo comando (`just dev`).
- [ ] Existe un `.env.example` si el proyecto requiere secretos.
- [ ] El `GEMINI.md` contiene al menos 3 reglas críticas de arquitectura.

---

## 4. Matriz de Adaptación Tecnológica

| Componente | Vanilla Web | Backend (Go/Python) | Cloud/Infra |
| :--- | :--- | :--- | :--- |
| **Linter** | Biome | Ruff / GoFmt | TFLint / Checkov |
| **Runtime** | Nginx / Node | Python / Go | Terraform / Pulumi |
| **EntryPoint** | `index.html` | `main.go` / `app.py` | `main.tf` |
| **Just Task** | `just serve` | `just run` | `just plan` |

---

## 5. Mantenimiento de este Estándar
Este documento debe ser revisado cada vez que una nueva herramienta o práctica demuestre mejorar la velocidad de entrega o la calidad del código en un factor de al menos 2x (ejemplo: la transición de Prettier/ESLint a Biome).
