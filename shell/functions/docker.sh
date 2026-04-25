#!/usr/bin/env bash

# --- [docker] Ultimate Database Orchestrator (Isolated Mode) ---
# Optimized workflow for managing database containers.

function db() {
    local DB_ROOT="$DOTFILES/os/cross-platform/docker/databases"
    local arg1=$1
    local arg2=$2
    local db_type=""
    local action=""
    
    local current_project=$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]//g')
    if [[ -z "$current_project" || "$current_project" == "$USER" || "$current_project" == "home" ]]; then
        current_project="global"
    fi

    if [[ "$arg1" == "-h" || "$arg1" == "--help" ]]; then
        echo -e "\033[1;34m󰆼 Database Orchestrator Help\033[0m"
        echo -e "----------------------------------"
        echo -e "\033[1;33mIsolated Project Context:\033[0m $current_project"
        echo -e "----------------------------------"
        local selected=$(echo -e "up\tLevantar el servicio (default)\nstop\tDetener el servicio\nclean\tDetener y BORRAR VOLÚMENES de este proyecto\nlogs\tVer logs en tiempo real\nsh\tEntrar al shell del contenedor\nps\tVer estado del servicio\nrestart\tReiniciar el servicio" | \
            column -t -s $'\t' | \
            fzf --prompt="󰑮 Select action for more info: " --height=40% --layout=reverse --border --header="Usage: db [action] <name>")
        
        [[ -n "$selected" ]] && echo -e "\n\033[1;32mCommand:\033[0m db $(echo $selected | awk '{print $1}') <name>"
        return 0
    fi

    case "$arg1" in
        up|stop|down|restart|logs|sh|shell|clean|ps)
            action=$arg1
            db_type=$arg2
            ;;
        "")
            db_type=$(ls -1 "$DB_ROOT" | fzf --prompt="󰆼 Select Database: " --height=40% --layout=reverse --border)
            [[ -z "$db_type" ]] && return 0
            action=$(echo -e "up\nstop\nclean\nlogs\nsh\nps" | fzf --prompt="󰑮 Action for $db_type ($current_project): " --height=40% --layout=reverse --border)
            [[ -z "$action" ]] && return 0
            ;;
        *)
            db_type=$arg1
            action=${arg2:-up}
            ;;
    esac

    local db_path="$DB_ROOT/$db_type"
    if [[ ! -d "$db_path" ]]; then
        echo -e "\033[1;31m󰚌 Error:\033[0m Database config '$db_type' not found in $DB_ROOT"
        return 1
    fi

    [[ -f .env ]] && export $(grep -v '^#' .env | xargs)

    pushd "$db_path" > /dev/null
    export COMPOSE_PROJECT_NAME="${current_project}-${db_type}"
    
    case "$action" in
        up)
            echo -e "\033[1;32m🚀 Starting $db_type for [$current_project]...\033[0m"
            docker-compose up -d
            ;;
        stop|down)
            echo -e "\033[1;33m🛑 Stopping $db_type for [$current_project]...\033[0m"
            docker-compose down
            ;;
        clean)
            echo -e "\033[1;31m🗑️  Cleaning $db_type for [$current_project] (Removing Volumes)...\033[0m"
            docker-compose down -v
            ;;
        restart)
            echo -e "\033[1;34m🔄 Restarting $db_type for [$current_project]...\033[0m"
            docker-compose restart
            ;;
        logs)
            docker-compose logs -f
            ;;
        sh|shell)
            echo -e "\033[1;34m🐚 Entering $db_type shell ($current_project)...\033[0m"
            docker-compose exec "$db_type" bash 2>/dev/null || docker-compose exec "$db_type" sh
            ;;
        ps)
            docker-compose ps
            ;;
        *)
            echo -e "\033[1;31mUnknown action:\033[0m $action"
            ;;
    esac
    popd > /dev/null
}

# --- [harlequin] Smart SQL TUI Connector ---
# Connects to databases using Harlequin with smart detection.
# Uses global Harlequin configuration for themes.

function hq() {
    local db_type=$1
    local DB_ROOT="$DOTFILES/os/cross-platform/docker/databases"

    # 1. Load local .env
    if [[ -f .env ]]; then
        export $(grep -v '^#' .env | xargs)
    fi

    # 2. Smart Detection (if db_type not provided)
    if [[ -z "$db_type" ]]; then
        if [[ "$DB_PORT" =~ ^330[0-9]$ ]]; then db_type="mysql"
        elif [[ "$DB_PORT" =~ ^543[0-9]$ ]]; then db_type="postgres"
        elif [[ "$DB_PORT" =~ ^143[0-9]$ ]]; then db_type="sqlserver"
        fi

        if [[ -z "$db_type" ]]; then
            db_type=$(ls -1 "$DB_ROOT" | fzf --prompt="󰆼 No se detectó motor, elige uno: " --height=40% --layout=reverse --border)
            [[ -z "$db_type" ]] && return 0
        fi
    fi

    # 3. Connection parameters
    local host="localhost"
    local user=${DB_USER:-admin}
    local pass=${DB_PASS:-password}
    local db_name=${DB_NAME:-dev_db}
    local port=${DB_PORT}

    echo -e "\033[1;34m󰆼 Connecting to $db_type (Harlequin)...\033[0m"

    case "$db_type" in
        mysql)
            port=${port:-3306}
            harlequin adapter mysql --host "$host" --port "$port" --user "$user" --password "$pass" --database "$db_name"
            ;;
        postgres)
            port=${port:-5432}
            harlequin adapter postgres --host "$host" --port "$port" --user "$user" --password "$pass" --database "$db_name"
            ;;
        sqlserver)
            port=${port:-1433}
            harlequin adapter odbc "Driver={ODBC Driver 18 for SQL Server};Server=$host,$port;Database=$db_name;UID=sa;PWD=$pass;Encrypt=no"
            ;;
        *)
            echo -e "\033[1;31mError:\033[0m Harlequin adapter for '$db_type' not configured."
            return 1
            ;;
    esac
}

alias db-up='db'
alias ld='lazydocker'
