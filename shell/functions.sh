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