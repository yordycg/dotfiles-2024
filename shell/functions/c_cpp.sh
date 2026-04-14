###############################################################################
# C & C++ DEVELOPMENT
###############################################################################

# Compilar y ejecutar C/C++ universal (soporta Makefile, CMake y archivos sueltos)
function rcc() {
  local input_path="${1:-.}"
  local args="${@:2}"
  local main_found=0
  local debug_mode=0
  local project_dir="$input_path"
  local input_file=""
  local compiler="g++"
  local std_flag="-std=c++17"

  # Verificar compilador según el archivo
  if [[ "$input_path" =~ \.c$ ]]; then
    compiler="gcc"
    std_flag="-std=c11"
    input_file="$input_path"
    main_found=1
  elif [[ "$input_path" =~ \.cpp$ ]]; then
    compiler="g++"
    std_flag="-std=c++17"
    input_file="$input_path"
    main_found=1
  fi

  # Modo Debug
  for arg in $args; do
    if [ "$arg" = "--debug" ]; then
      debug_mode=1
      args=$(echo "$args" | sed 's/--debug//')
      break
    fi
  done

  # Si es un directorio, buscar main.c o main.cpp
  if [ -d "$project_dir" ]; then
    if [ -f "$project_dir/main.c" ]; then
      input_file="$project_dir/main.c"
      compiler="gcc"
      std_flag="-std=c11"
      main_found=1
    elif [ -f "$project_dir/main.cpp" ]; then
      input_file="$project_dir/main.cpp"
      compiler="g++"
      std_flag="-std=c++17"
      main_found=1
    elif [ -f "$project_dir/src/main.c" ]; then
      input_file="$project_dir/src/main.c"
      compiler="gcc"
      std_flag="-std=c11"
      main_found=1
    elif [ -f "$project_dir/src/main.cpp" ]; then
      input_file="$project_dir/src/main.cpp"
      compiler="g++"
      std_flag="-std=c++17"
      main_found=1
    fi

    # Lógica de Makefile/CMake
    if [ -f "$project_dir/Makefile" ]; then
      echo "--- Makefile detectado ---"
      [ $debug_mode -eq 1 ] && make -C "$project_dir" DEBUG=1 || make -C "$project_dir"
      return $?
    elif [ -f "$project_dir/CMakeLists.txt" ]; then
      echo "--- CMake detectado ---"
      mkdir -p "$project_dir/build" && cd "$project_dir/build"
      [ $debug_mode -eq 1 ] && cmake -DCMAKE_BUILD_TYPE=Debug .. || cmake -DCMAKE_BUILD_TYPE=Release ..
      make && ./main $args
      cd .. && return $?
    fi
  fi

  # Compilación manual de archivo suelto
  if [ $main_found -eq 1 ]; then
    local output="${input_file%.*}"
    local opts=($std_flag -Wall -Wextra -Wpedantic)
    
    if [ $debug_mode -eq 1 ]; then
      opts+=(-ggdb -O0)
    else
      opts+=(-O2 -DNDEBUG)
    fi

    echo "Compilando con $compiler..."
    $compiler "${opts[@]}" -o "$output" "$input_file"
    
    if [ $? -eq 0 ]; then
      echo "Ejecutando $output..."
      "./$output" $args
    fi
  else
    echo "Error: No se encontró un archivo main.c o main.cpp"
    return 1
  fi
}

# Crear proyecto básico (C o CPP)
function bproj() {
  local name=$1
  local type=${2:-cpp} # default a cpp si no se especifica

  mkdir -p "$name/src"
  if [ "$type" = "c" ]; then
    cat <<EOF >"$name/src/main.c"
#include <stdio.h>

int main() {
    printf("Hola desde C!\n");
    return 0;
}
EOF
  else
    cat <<EOF >"$name/src/main.cpp"
#include <iostream>

int main() {
    std::cout << "Hola desde C++!" << std::endl;
    return 0;
}
EOF
  fi
  echo "Proyecto $type creado en $name/"
  cd "$name"
}

# Limpiar binarios
function cleanc() {
  find . -type f -not -path "*/.*" -perm -111 -not -name "*.sh" -not -name "*.py" -delete
  echo "Binarios eliminados."
}
