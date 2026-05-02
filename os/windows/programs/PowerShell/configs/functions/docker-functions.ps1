# -----------------------------------------------------------------------------
# Docker & Docker Compose Specialized Functions
# -----------------------------------------------------------------------------

# Docker Compose (Modern 'docker compose' V2)
function dcu   { docker compose up $args }
function dcud  { docker compose up -d $args }
function dcd   { docker compose down $args }
function dcr   { docker compose down; docker compose up -d $args }
function dcl   { docker compose logs -f $args }
function dce   { docker compose exec $args }
function dcb   { docker compose build $args }

# Docker Basics
function dps   { docker ps $args }
function dpsa  { docker ps -a $args }
function di    { docker images $args }
function dv    { docker volume ls $args }
function dn    { docker network ls $args }

# Container Management
function dstart { docker start $args }
function dstop  { docker stop $args }
function drm    { docker rm -f $args }
function drmi   { docker rmi -f $args }
function dex    { docker exec -it $args }
function dl     { docker logs -f $args }

# Maintenance
function dprune { docker system prune -f }
function dpruneall { docker system prune -a --volumes -f }

function dclean {
    Write-Host "Cleaning up Docker resources..." -ForegroundColor Cyan
    docker container prune -f
    docker image prune -f
    docker network prune -f
    docker volume prune -f
    Write-Host "Docker cleanup completed!" -ForegroundColor Green
}
