# Compile for C++
# function bcpp() {
#   if [[ ! $1 =~ \.cpp$ ]]; then
#     echo "Error: file don't have .cpp extension"
#     return 1
#   fi
#
#   local output="${1%.*}" # Remove .cpp extension for output file
#   g++ -std=c++23 -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion \
#       -Wpedantic -Werror -ggdb -O2 -DNDEBUG -pedantic-errors \
#       -o "$output" "$1"
# }
function rcpp() {
  local input_path="$1"
  local args="${@:2}"
  local src_main=""
  local main_found=0
  local debug_mode=0
  local project_dir="$input_path" # Almacenar el directorio del proyecto

  # Comprobar si g++ está instalado
  if ! command -v g++ &>/dev/null; then
    echo "Error: g++ no está instalado"
    return 1
  fi

  # Verificar si se solicita modo debug
  for arg in $args; do
    if [ "$arg" = "--debug" ]; then
      debug_mode=1
      args=$(echo "$args" | sed 's/--debug//')
      break
    fi
  done

  # Buscar main.cpp en el directorio del proyecto
  if [ -f "$project_dir/main.cpp" ]; then
    input_file="$project_dir/main.cpp"
    main_found=1
    # echo "Encontrado main.cpp en $project_dir, compilando..."

  # Buscar main.cpp en src/ si no se encontró en el directorio del proyecto
  elif [ -d "$project_dir/src" ] && [ -f "$project_dir/src/main.cpp" ]; then
    src_main="$project_dir/src/main.cpp"
    input_file="$src_main"
    main_found=1
    # echo "Encontrado src/main.cpp en $project_dir, compilando..."

  # Si no se proporciona un archivo y no se encuentra main.cpp
  elif [ -z "$input_path" ]; then
    echo "Error: No se proporcionó archivo y no se encontró main.cpp"
    echo ""
    return 1
  fi

  # Verificar si hay un Makefile o CMakeLists.txt
  if [ -f "$project_dir/Makefile" ]; then
    echo "Makefile encontrado, ejecutando make..."
    if [ $debug_mode -eq 1 ]; then
      make -C "$project_dir" DEBUG=1
    else
      make -C "$project_dir"
    fi
    local make_status=$?
    if [ $make_status -eq 0 ] && [ $main_found -eq 1 ]; then
      echo "Ejecutando programa..."
      "$project_dir/main" $args
    fi
    return $make_status
  elif [ -f "$project_dir/CMakeLists.txt" ]; then
    echo "CMakeLists.txt encontrado, ejecutando cmake y make..."
    if [ ! -d "$project_dir/build" ]; then
      mkdir "$project_dir/build"
    fi
    cd "$project_dir/build"
    if [ $debug_mode -eq 1 ]; then
      cmake -DCMAKE_BUILD_TYPE=Debug ..
    else
      cmake -DCMAKE_BUILD_TYPE=Release ..
    fi

    if [ $? -ne 0 ]; then
      echo "Error durante la ejecución de cmake"
      cd ..
      return 1
    fi

    make
    local make_status=$?
    cd ..

    if [ $make_status -eq 0 ] && [ $main_found -eq 1 ]; then
      echo "Ejecutando programa..."
      "$project_dir/build/main" $args
    fi
    return $make_status
  fi

  # Verificar la extensión .cpp
  if [[ ! "$input_file" =~ \.cpp$ ]]; then
    echo "Error: El archivo no tiene extensión .cpp"
    return 1
  fi

  # Configurar output para preservar estructura de directorios
  if [ "$input_file" = "$src_main" ] || [ "$input_file" = "$project_dir/main.cpp" ]; then
    local output="$project_dir/main"
  else
    local basename=$(basename "$input_file")
    local output="$project_dir/${basename%.*}"
  fi

  # Configurar opciones de compilación según modo debug o release
  local compile_options
  if [ $debug_mode -eq 1 ]; then
    # echo "Compilando en modo debug..."
    compile_options=(-std=c++17 -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Wpedantic -ggdb -O0)
  else
    # echo "Compilando en modo release..."
    compile_options=(-std=c++17 -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Wpedantic -Werror -ggdb -O2 -DNDEBUG -pedantic-errors)
  fi

  # Compilar
  g++ "${compile_options[@]}" -o "$output" "$input_file"

  # Verificar si la compilación fue exitosa y ejecutar el programa
  if [ $? -eq 0 ]; then
    echo "Compilación exitosa: $output"
    if [ $main_found -eq 1 ] || [ -z "$input_path" ]; then
      echo "Ejecutando programa..."
      echo ""
      "$output" $args
      echo ""
    fi
    return 0
  else
    echo "Error durante la compilación"
    return 1
  fi
}

# BASIC compile and run cpp
function r() {
  FILE="$1"
  OUTPUT=$(basename "$FILE" .cpp)

  g++ "$FILE" -o "$OUTPUT" # compile...

  # Verificar compilacion...
  if [ $? -eq 0 ]; then
    ./"$OUTPUT" # compilacion exitosa...
  else
    # Fallo de compilacion...
    echo "--- La compilacion fallo ---"
    return 1
  fi
}

# Basic project for C++
function bpcpp() {
  # Verificar si se proporcionó el nombre del proyecto
  if [ -z "$1" ]; then
    echo "Uso: bpcpp project_name [-y]"
    return 1
  fi

  project_name=$1

  # Crear directorio
  mkdir -p "$project_name/src"

  # Crear archivo main.cpp
  touch "$project_name/src/main.cpp"

  # Agregar estructura básica si se especificó -y
  cat <<EOF >"$project_name/src/main.cpp"
#include <iostream>

int main() {
    std::cout << "Hola mundo!" << std::endl;

    std::cout << std::endl;
    return 0;
}
EOF

  echo "Proyecto básico C++, creado en $project_name/"

  cd "$project_name"
}

# Full project for C++
# TODO: add a basic structure to main.cpp
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

# Limpiar binarios generados
function cleancpp() {
  find . -type f -not -path "./build/*" -not -name "*.cpp" -not -name "*.h" -perm -111 -delete
}

# Crear y entrar a un directorio
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Buscar contenido con ripgrp y fzf
findedit() {
  local file=$(
    rg --line-number --no-heading --color=always --smart-case "$1" |
      fzf --ansi --preview "bat {1} --highlight-line {2}"
  )
  if [[ -n $file ]]; then
    vim "$(echo "$file" | cut -d':' -f1)" "+$(echo "$file" | cut -d':' -f2)"
  fi
}

# Gestionar sesiones con tmux
function tat {
  name=$(basename $(pwd) | sed -e 's/\.//g')
  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}
