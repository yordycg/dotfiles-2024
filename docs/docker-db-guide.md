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

Como usas el sistema de **paquetes nativo de Neovim**, para habilitar `vim-dadbod` debes agregar estos repositorios a tu archivo de plugins:

### Flujo de Trabajo en Neovim:
1.  Ejecuta `:DBUI` para abrir el panel lateral.
2.  Presiona `A` para agregar una conexión (usa las mismas URLs de la tabla de Harlequin).
3.  Usa el autocompletado en archivos `.sql` gracias a `cmp-dadbod`.

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
