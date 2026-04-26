# 🔐 Workflow: Gestión Profesional de Variables de Entorno (.env)

Este documento describe el estándar adoptado en estos dotfiles para manejar configuraciones y secretos de forma segura y eficiente.

## 🛠️ Herramientas Utilizadas
1.  **`gen-env`**: Función personalizada para inicializar archivos `.env` y `.env.example`.
2.  **`sync-env`**: Sincronizador automático de llaves entre el archivo local y la plantilla pública.
3.  **`direnv`**: Carga/descarga automática de variables al entrar/salir de directorios.
4.  **`dotenv-linter`**: Validador de formato y buenas prácticas.

---

## 🚀 Flujo de Trabajo

### 1. Inicialización del Proyecto
Al empezar un nuevo proyecto, usa el comando `gen-env` para preparar el terreno:
```bash
gen-env [template]
```
- **¿Qué hace?**: Crea `.env`, `.env.example`, configura `.envrc` para `direnv` y añade las protecciones necesarias a `.gitignore`.
- **Templates**: Soporta `mysql`, `postgres`, `sqlserver` y `empty`.

### 2. Carga Automática
Gracias a `direnv`, no necesitas hacer `export` manualmente. Al entrar a la carpeta verás:
`direnv: loading ~/project/.envrc`
Las variables ya están disponibles en tu shell.

### 3. Mantenimiento y Colaboración
Si añades una nueva variable a tu `.env` (ej: `API_KEY=secret123`), debes actualizar la plantilla para tus compañeros:
```bash
sync-env
```
- **Resultado**: Añadirá `API_KEY=` al archivo `.env.example` (sin el valor secreto) y pasará el linter para asegurar que el formato sea correcto.

---

## ⚖️ Reglas de Oro
1.  **NUNCA** subas el archivo `.env` al repositorio. `gen-env` intenta protegerte añadiéndolo al `.gitignore` automáticamente.
2.  **SIEMPRE** mantén actualizado el `.env.example`. Es el contrato que permite a otros (o a tu "yo" del futuro) saber qué variables necesita el proyecto.
3.  **Usa MAYÚSCULAS**: Las variables de entorno deben ir en `GRITAR_SNAKE_CASE`. El linter te avisará si lo olvidas.
