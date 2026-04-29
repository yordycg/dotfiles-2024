# 🐳 Guía: Flujo de Trabajo Profesional con Bases de Datos y Docker

Esta guía detalla cómo gestionar bases de datos (MySQL, PostgreSQL, SQL Server) de forma aislada, segura y profesional utilizando las herramientas configuradas en tus `dotfiles`.

---

## 🛠 1. Inicialización de Proyecto (`gen-env`)

Antes de empezar, cada proyecto debe tener su propia configuración de entorno. El comando `gen-env` automatiza este proceso.

1.  Navega a la carpeta de tu proyecto.
2.  Ejecuta: `gen-env`
3.  Selecciona el motor deseado (`mysql`, `postgres`, `sqlserver`).

**¿Qué hace este comando?**
- Crea un archivo `.env` con variables esenciales.
- Genera un archivo **`docker-compose.yml` local** y portable.
- Genera una **contraseña segura aleatoria**.
- Configura el nombre de la DB basado en el nombre de tu carpeta.
- **Seguridad:** Añade automáticamente el archivo `.env` a tu `.gitignore` para evitar fugas de credenciales.

---

## 🚀 2. Orquestación Aislada (`db-docker`)

El comando `db-docker` gestiona contenedores **aislados por proyecto**. 

### Portabilidad y Prioridad:
1.  **Prioridad Local:** Si `db-docker` detecta un `docker-compose.yml` en la carpeta actual, lo usará automáticamente. Esto permite que el proyecto sea portable: cualquier desarrollador puede clonarlo y ejecutar `docker-compose up -d` sin depender de tus dotfiles.
2.  **Fallback Global:** Si no hay un archivo local, usará las configuraciones base de tus dotfiles (`os/cross-platform/docker/databases/`).

### Comandos Principales:
| Comando | Acción |
| :--- | :--- |
| `db-docker` | **Modo Interactivo (FZF)** para elegir motor y acción. |
| `db-docker up` | Levanta la base de datos (usa el archivo local si existe). |
| `db-docker stop` | Detiene el servicio sin borrar datos. |
| `db-docker clean`| **Limpieza Total:** Detiene y BORRA los volúmenes (datos) de este proyecto. |
| `db-docker logs` | Ver logs del contenedor en tiempo real. |
| `db-docker sh`   | Entrar al shell (bash/sh) del contenedor. |

> [!TIP]
> **Puertos Dinámicos:** Si quieres trabajar en dos proyectos MySQL a la vez, cambia `DB_PORT=3307` en el `.env` del segundo proyecto. El comando `db-docker` lo detectará automáticamente.

---

## 🐚 3. Consulta Interactiva TUI (`hq`)

Para explorar datos rápidamente con una interfaz visual en la terminal, usamos **Harlequin**.

1.  Desde la carpeta de tu proyecto, ejecuta: `hq`
2.  **Detección Inteligente:** `hq` leerá tu `.env`, detectará el puerto y el motor, y te conectará automáticamente.
3.  **Estética:** Se sincroniza con tu tema global (`gruvbox`, `catppuccin`, etc.).

---

## ⚡ 4. Gestión desde Neovim (Editor Pro)

Tu Neovim es ahora un cliente SQL completo que detecta tu entorno Docker automáticamente.

### Atajos de Teclado (Keymaps):
| Comando | Acción |
| :--- | :--- |
| `<leader>du` | **Abrir/Cerrar** el explorador de bases de datos (`Dadbod UI`). |
| `<leader>S` | **Ejecutar Query** (sobre la línea actual o selección visual). |

### Flujo de Trabajo en Neovim:
1.  **Detección:** Al abrir Neovim en un proyecto con `.env`, la conexión aparecerá automáticamente en el panel lateral.
2.  **Exploración:** Usa `<leader>du` para ver tablas, columnas e índices.
3.  **Ejecución:** Abre un archivo `.sql`, escribe tu consulta y presiona `Espacio + S`.
4.  **Sin Dependencias:** Neovim utiliza un **Docker Bridge**. No necesitas tener instalados los clientes de MySQL/Postgres en tu Arch Linux; Neovim usa los que ya están dentro de Docker.

---

## 📂 5. Estructura de Persistencia

Los datos se guardan en volúmenes de Docker nombrados con el prefijo del proyecto:
- `PROYECTO-mysql_mysql_data`
- `PROYECTO-postgres_postgres_data`

Esto garantiza que al hacer un `db-docker clean`, solo afectes al proyecto actual.

---

## 📋 6. Resumen de comandos rápidos
```bash
# 1. Crear entorno
gen-env mysql

# 2. Levantar DB
db-docker up mysql

# 3. Consultar (Terminal)
hq

# 4. Consultar (Neovim)
v .  # Y luego <leader>du
```
