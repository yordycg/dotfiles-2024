# 🐳 Guía: Flujo de Trabajo Profesional con Bases de Datos y Docker

Esta guía detalla cómo gestionar bases de datos (MySQL, PostgreSQL, etc.) de forma eficiente usando las herramientas configuradas en tus `dotfiles`.

---

## 🚀 1. Levantando la Base de Datos (Terminal)

Hemos implementado una función inteligente llamada `db-up`. 

### Comandos Básicos:
| Acción | Comando |
| :--- | :--- |
| **Levantar DB** | `db-up <db_name>` |
| **Detener DB** | `db-up <db_name> down` |
| **Ver Logs** | `db-up <db_name> logs` |
| **Entrar al Shell** | `db-up <db_name> shell` |

> [!NOTE]
> Configuración en: `$DOTFILES/os/cross-platform/docker/databases/<db_name>/docker-compose.yml`.

---

## 🐚 2. Consulta Interactiva (Universal SQL TUI)

Para una experiencia Pro en la terminal, usamos **Harlequin** (`hq`). Es un cliente universal que funciona con todas tus bases de datos Docker.

### Cómo conectar con Harlequin:
Usa el alias `hq` seguido del adaptador (`-t`) y la cadena de conexión:

| Base de Datos | Comando de Conexión |
| :--- | :--- |
| **PostgreSQL** | `hq -t postgres "postgres://user:password@localhost:5432/dev_db"` |
| **MySQL** | `hq -t mysql "mysql://user:password@localhost:3306/dev_db"` |
| **SQLite** | `hq -t sqlite ./ruta/a/la/base.db` |
| **SQL Server** | `hq -t odbc "Driver={ODBC Driver 18 for SQL Server};Server=localhost,1433;UID=sa;PWD=Password123;Encrypt=no"` |

### ¿Por qué Harlequin?
- **Universal:** Una sola herramienta para todo.
- **Visual:** Explorador de tablas lateral y visor de resultados tipo Excel.
- **Tematizado:** Se sincroniza automáticamente con tus temas de Ghostty/Neovim.

> [!TIP]
> Si solo necesitas una consulta ultra-rápida en MySQL, puedes seguir usando `mycli -h localhost -u user -p password dev_db`.

---

## ⚡ 3. Gestión desde Neovim (Editor Pro)

Tu configuración de Neovim incluye `vim-dadbod` y `vim-dadbod-ui`, lo que convierte a tu editor en un cliente SQL completo.

### Atajos de Teclado (Keymaps):
| Comando | Acción |
| :--- | :--- |
| `<leader>du` | **Abrir/Cerrar** el panel de base de datos (`DBUI`). |
| `<leader>S` | **Ejecutar Query** (sobre la línea actual o selección visual). |
| `<leader>df` | Buscar el buffer de base de datos actual. |
| `<leader>dr` | Renombrar el buffer de consulta actual. |

### Flujo de Trabajo Profesional:

1.  **Levantar el servicio:** Primero asegúrate de que el contenedor esté corriendo con `db-up mysql`.
2.  **Conectar:** Abre el panel con `<leader>du`, presiona `A` (Add Connection) y pega la URL:
    - *Ejemplo MySQL:* `mysql://user:password@localhost:3306/dev_db`
    - *Ejemplo Postgres:* `postgres://user:password@localhost:5432/dev_db`
3.  **Explorar:** Navega por las tablas con `j/k` y presiona `Enter` para ver el esquema o los datos.
4.  **Escribir y Ejecutar:**
    - Crea un archivo `.sql` (ej: `test.sql`).
    - Escribe tu consulta: `SELECT * FROM users;`.
    - Presiona `<leader>S` para ejecutarla. Los resultados se abrirán en un panel vertical a la derecha.
5.  **Autocompletado Inteligente:** Al escribir en un archivo `.sql`, el editor te sugerirá automáticamente nombres de tablas y columnas de la base de datos activa.

> [!NOTE]
> Las consultas que ejecutas se guardan automáticamente en la carpeta `db_ui` dentro de tu proyecto, permitiéndote reutilizarlas después.

---

## 🛠 4. Datos de Conexión (Por Defecto)

| Parámetro | Valor (MySQL/Postgres) | Valor (SQL Server) |
| :--- | :--- | :--- |
| **Host** | `localhost` | `localhost` |
| **Puerto** | `3306 / 5432` | `1433` |
| **Usuario** | `user` | `sa` |
| **Password** | `password` | `Password123!` |
| **Database** | `dev_db` | `master` |

---

## 📂 5. Limpieza de Datos
Si quieres resetear la base de datos por completo (borrar volúmenes):
```bash
db-up <db_name> down -v
```
