function ld {
    lazydocker
}

# Docker Compose functions
function dcb {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose build $args
}

function dcd {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose down $args
}

function dce {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$service,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose exec $service $args
}

function dcl {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose logs $args
}

function dcu {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose up $args
}

function dcud {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose up -d $args
}

function dcr {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker-compose down
    docker-compose up -d $args
}

# Docker container functions
function dps {
    docker ps
}

function dpsa {
    docker ps -a
}

function dstart {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$container
    )
    docker start $container
}

function dstop {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$container
    )
    docker stop $container
}

function drm {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$container
    )
    docker rm $container
}

function drmi {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$image
    )
    docker rmi $image
}

function dexec {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$container,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker exec -it $container $args
}

function dlogs {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$container,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker logs $container $args
}

function dprune {
    docker system prune -f
}

function dpruneall {
    docker system prune -a -f
}

function dvols {
    docker volume ls
}

function dnetworks {
    docker network ls
}

function dimages {
    docker images
}

function dbuild {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$tag,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    docker build -t $tag $args .
}

function dpull {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$image
    )
    docker pull $image
}

function dpush {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$image
    )
    docker push $image
}

function dclean {
    # Remove all stopped containers
    Write-Host "Removing stopped containers..."
    docker container prune -f

    # Remove all dangling images
    Write-Host "Removing dangling images..."
    docker image prune -f

    # Remove all unused networks
    Write-Host "Removing unused networks..."
    docker network prune -f

    # Remove all unused volumes
    Write-Host "Removing unused volumes..."
    docker volume prune -f

    Write-Host "Docker cleanup completed!" -ForegroundColor Green
}