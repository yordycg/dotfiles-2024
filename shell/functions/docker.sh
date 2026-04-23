#!/usr/bin/env bash

# --- [docker] Database Orchestration Function ---
# This function allows starting up common databases in docker easily.
# Based on Priority 5 of the TODO.md

function db-up() {
    local db_type=$1
    local action=${2:-up} # Default action is 'up'

    if [[ -z "$db_type" ]]; then
        echo -e "\033[1;34mUsage:\033[0m db-up <type> [up|down|logs|shell]"
        echo -e "\033[1;32mAvailable:\033[0m"
        ls -1 "$DOTFILES/os/cross-platform/docker/databases"
        return 1
    fi

    # 1. Load project-specific .env if it exists in current working directory
    if [[ -f .env ]]; then
        echo -e "\033[1;36m💡 Found .env in current directory. Loading variables...\033[0m"
        export $(grep -v '^#' .env | xargs)
    fi

    # Path to the database configurations in dotfiles
    local db_path="$DOTFILES/os/cross-platform/docker/databases/$db_type"

    if [[ ! -d "$db_path" ]]; then
        echo -e "\033[1;31mError:\033[0m Configuration for '$db_type' not found."
        return 1
    fi

    # Ensure we are in the correct directory for docker-compose
    pushd "$db_path" > /dev/null
    
    case "$action" in
        up)
            echo -e "\033[1;32m🚀 Starting $db_type container...\033[0m"
            docker-compose up -d
            ;;
        down)
            echo -e "\033[1;33m🛑 Stopping $db_type container...\033[0m"
            docker-compose down
            ;;
        logs)
            docker-compose logs -f
            ;;
        shell)
             echo -e "\033[1;34m🐚 Entering $db_type shell...\033[0m"
             docker-compose exec "$db_type" bash 2>/dev/null || docker-compose exec "$db_type" sh
             ;;
        *)
            echo -e "\033[1;31mUnknown action:\033[0m $action. Use up|down|logs|shell"
            ;;
    esac

    popd > /dev/null
}

# Alias for lazydocker if not already set
alias ld='lazydocker'
