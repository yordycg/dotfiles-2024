#!/usr/bin/env bash

# --- [docker] Database CLI Bridge ---
# This script acts as a proxy to run database CLI tools (mysql, psql, etc.)
# inside their respective Docker containers instead of the host machine.

COMMAND=$(basename "$0")
# Get the project name from the current directory (consistent with our 'db' function)
PROJECT_NAME=$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]//g')

# Function to find the container and execute the command
run_in_container() {
    local db_type=$1
    shift
    local container_name="${PROJECT_NAME}-${db_type}"
    
    # Check if the container is running
    if ! docker ps --format '{{.Names}}' | grep -q "^${container_name}"; then
        # Fallback: find any running container of that type if the project-specific one isn't found
        container_name=$(docker ps --format '{{.Names}}' | grep "${db_type}" | head -n 1)
    fi

    if [[ -z "$container_name" ]]; then
        echo "Error: No running container found for $db_type" >&2
        exit 1
    fi

    # Execute the command inside the container
    # -i is needed for Dadbod to send the query via stdin
    docker exec -i "$container_name" "$db_type" "$@"
}

case "$COMMAND" in
    mysql)
        run_in_container "mysql" "$@"
        ;;
    psql)
        run_in_container "postgres" "$@"
        ;;
    sqlcmd)
        run_in_container "sqlserver" "$@"
        ;;
    *)
        echo "Unsupported command: $COMMAND"
        exit 1
        ;;
esac
