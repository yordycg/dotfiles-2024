# Compile for C++
function buildcpp() {
  if [[ ! $1 =~ \.cpp$ ]]; then
    echo "Error: file don't have .cpp extension"
    return 1
  fi

  local output="${1%.*}" # Remove .cpp extension for output file
  g++ -std=c++23 -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion \
      -Wpedantic -Werror -ggdb -O2 -DNDEBUG -pedantic-errors \
      -o "$output" "$1"
}

# Basic project for C++
function basic_proj_cpp() {
    # Verificar si se propociono el nombre del proyecto
    if [ -z "$1"]; then
        echo "Uso: basic_proj_cpp project_name"
        return 1
    fi

    project_name=$1

    # Crear directorio
    mkdir -p "$project_name/src"
    
    # Crear archivo main.cpp
    touch "$project_name/src/main.cpp"
    
    echo "Proyecto basico C++, creado en $project_name/"
}

# Full project for C++
function full_proj_cpp() {
    # Verificar si se propociono el nombre del proyecto
    if [ -z "$1"]; then
        echo "Uso: full_proj_cpp project_name"
        return 1
    fi

    project_name=$1

    # Crear directorios
    mkdir -p "$project_name"/{src,include,lib,tests,build,docs}

    # Crear archivo main.cpp
    touch "$project_name/src/main.cpp"

    # TODO: agregar .gitignore, CMAKE (aprender), README del proyecto
    
    echo "Proyecto completo C++, creado en $project_name/"

}
