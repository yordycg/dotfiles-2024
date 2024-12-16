#!/usr/bin/bash
# Script found: https://github.com/dDeedev/install-nerd-font-linux

version="3.3.0"
fonts_dir="${HOME}/.local/share/fonts"

declare -a fonts=(
  CascadiaCode
  FiraCode
  Hack
  JetBrainsMono
  Meslo
  RobotoMono
  Ubuntu
  UbuntuMono
)

# If not exist font directory, created
if [[ ! -d "$fonts_dir" ]]; then
  mkdir -p "$fonts_dir"
fi

# Download fonts and installed
for font in "${fonts[@]}"; do
  zip_file="${font}.zip"
  download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
  echo "Downloading $download_url"
  wget "$download_url"
  unzip -o "$zip_file" -d "$fonts_dir" # "-o" nos permite sobrescribir el README.md que se descarga con cada fuente
  rm "$zip_file"
done

# Delete fonst with "windows compatible"
find "$fonts_dir" -name '*Windows Compatible*' -delete

# Update font cache
fc-cache -fv
