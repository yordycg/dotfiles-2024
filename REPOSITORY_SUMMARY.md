# Resumen del Repositorio `dotfiles-2024`

Este documento resume el análisis del repositorio `dotfiles-2024`, destacando su estructura, propósito y las principales configuraciones encontradas.

## 1. Estructura General y Propósito

El repositorio `dotfiles-2024` es una colección altamente organizada, modular y multiplataforma de configuraciones personales para entornos de desarrollo. Utiliza enlaces simbólicos para gestionar la colocación de archivos de configuración en sus ubicaciones de sistema correspondientes. Su objetivo principal es automatizar la configuración de un entorno de desarrollo productivo y consistente en diferentes sistemas operativos (Linux, Windows/WSL) y con diversas herramientas.

## 2. Configuraciones del Editor (Neovim)

El usuario mantiene múltiples configuraciones de Neovim, lo que sugiere experimentación o configuraciones especializadas:

*   **`nvim-kickstart`**: Configuración basada en Lua que usa `lazy.nvim` para la gestión de plugins, con autocmds, keymaps, opciones y una variedad de plugins.
*   **`nvim-lazy-2025`**: Otra configuración basada en Lua y `lazy.nvim`, siguiendo una estructura similar a LazyVim.
*   **`nvim-nvchad`**: Una distribución de NvChad, también basada en Lua con `lazy.nvim`, con adiciones personalizadas.
*   **`nvim-vim`**: Una configuración clásica basada en Vim-script, enfocada en el desarrollo de C++, ofreciendo una configuración más sencilla pero funcional.

## 3. Configuraciones de Git

La configuración de Git es muy completa y está diseñada para entornos de desarrollo complejos:

*   **`.gitconfig`**: Contiene información de usuario global, configuraciones básicas, comportamientos de ramas, formatos de log y un extenso conjunto de alias. Destaca el uso de `delta` para las diferencias y las inclusiones condicionales (`[includeIf "gitdir:..."]`) para gestionar identidades de Git (personal, trabajo, IPVG) según la ruta del repositorio.
*   **`setup-git-ssh.ps1`**: Un script de PowerShell utilizado para configurar las claves SSH de Git, integrado en el proceso de configuración de Windows.

## 4. Configuraciones Específicas del Sistema Operativo (`os/`)

Las configuraciones se dividen en multiplataforma, Linux y Windows.

### 4.1. Configuraciones Multiplataforma (`os/cross-platform/`)

*   **`clangd/`**: Contiene `.clang-format` (formato de código C++ basado en Google con reglas personalizadas) y `.clangd` (flags de compilación C++17 estrictos, advertencias extensas y soporte para depuración con `-Werror`). Esto subraya un enfoque en la alta calidad del código.
*   **`starship/`**: Configura el prompt de shell `Starship` para una visualización informativa y personalizada, integrando versiones de lenguajes y usando "nord" como tema por defecto.
*   **`wezterm/`**: Configura el emulador de terminal `WezTerm` con fuentes personalizadas (CaskaydiaCove Nerd Font), colores, efectos de fondo semi-transparentes y una integración modular de comandos.

### 4.2. Configuraciones de Linux (`os/linux/`)

### 4.2.1. Entorno de Escritorio Hyprland (Basado en `simple-hyprland`)

Se ha integrado la configuración base para el entorno de escritorio Hyprland en Arch Linux, tomando como referencia el repositorio minimalista `gaurav23b/simple-hyprland`. Los archivos de configuración para los siguientes componentes han sido copiados a sus respectivos directorios dentro de `os/linux/`:

*   **Hyprland**: Configuración principal (`hyprland.conf`, `hypridle.conf`, `hyprlock.conf`)
*   **Kitty**: Terminal (`kitty.conf`, `theme.conf`)
*   **Waybar**: Barra de estado (`config.jsonc`, `style.css`)
*   **Dunst**: Servidor de notificaciones (`dunstrc`) - *Nota: El script de instalación sugiere `mako` como servidor de notificaciones. Si se opta por `mako`, su configuración deberá ser creada/adaptada, ya que los archivos copiados son para `dunst`.*
*   **Wlogout**: Gestor de sesiones (`layout`, `style.css`)
*   **Tofi**: Lanzador de aplicaciones (`configA`, `configV`)

Estos archivos son el punto de partida para una configuración personalizada de Hyprland, gestionada a través de este repositorio de dotfiles.

### 4.2.2. Script de Post-Instalación de Arch Linux (`post-install-arch`)

Se ha desarrollado un script de post-instalación modular para Arch Linux, ubicado en `os/linux/post-install-arch/`. Su propósito es automatizar la configuración de un nuevo sistema Arch Linux, incluyendo la instalación de paquetes y el despliegue de los dotfiles. La estructura del script incluye:

*   **`install.sh`**: Script principal que orquesta la ejecución de los módulos.
*   **`00-yay.sh`**: Instala o actualiza el gestor de paquetes AUR `yay`.
*   **`01-packages.sh`**: Instala paquetes desde los repositorios oficiales y AUR, definidos en `packages/pkglist-official.txt` y `packages/pkglist-aur.txt` respectivamente.
*   **`02-dotfiles.sh`**: Ejecuta el script `setup-symlinks.sh` (en la raíz del repositorio) para establecer los enlaces simbólicos de los dotfiles.
*   **`03-services.sh`**: Configura y habilita servicios del sistema (ej. `sddm`).

Adicionalmente, se ha creado un script `bootstrap.sh` en la raíz del repositorio. Este permite ejecutar todo el proceso de instalación y configuración con un único comando en un sistema Arch Linux recién instalado.

*   **`font-installer.sh` & `nerd-fonts-installer.sh`**: Scripts bash para la instalación automática de Nerd Fonts.
*   **Terminales**: Configuraciones para `alacritty`, `ghostty` y `kitty`, todas con preferencias similares en fuentes (JetBrains Mono), padding y transparencia.
*   **`scripts/`**: Incluye `cr` (un script sofisticado para compilar, ejecutar y depurar C++) y `tmux-attach.sh` (para la gestión automatizada de sesiones de Tmux).
*   **`tmux/`**: Una configuración extensa de Tmux que utiliza `tpm` (Tmux Plugin Manager) para numerosos plugins, una tecla de prefijo personalizada y carga condicional de temas.

### 4.3. Configuraciones de Windows (`os/window/`)

Esta sección detalla una configuración altamente automatizada del entorno de desarrollo de Windows usando PowerShell:

*   **`setup-window.ps1`**: El script principal de PowerShell que orquesta la configuración de Windows, incluyendo escalada de privilegios, registro, carga de funciones y configuraciones.
*   **`config/config.json`**: Archivo central de configuración para `setup-window.ps1`, definiendo correos electrónicos, rutas, una lista completa de aplicaciones de Scoop, repositorios Git a clonar, enlaces simbólicos y directorios a crear.
*   **`functions/`**: Scripts modulares de PowerShell para tareas como instalar Scoop, gestionar directorios/symlinks, resolver rutas y sincronizar repositorios Git.
*   **`programs/`**: Configuraciones específicas para PowerShell y Windows Terminal.
*   **`scripts/wsl-setup-script.ps1`**: Un script detallado de PowerShell para automatizar completamente la configuración de WSL2 para el desarrollo de C++, incluyendo instalación de WSL, configuración del entorno C++, integración con VSCode/CLion, accesos directos y utilidades de respaldo/restauración.

## 5. Configuraciones de Shell (`shell/`)

Las configuraciones de shell son altamente optimizadas para productividad.

*   **`aliases.sh`**: Una extensa colección de alias de shell para comandos del sistema, navegación de directorios, `eza` (como `ls`), operaciones de Git (con integración de `fzf` y `lazygit`), GitHub CLI, Docker y varias utilidades.
*   **`exports.sh`**: Define variables de entorno, principalmente para `fzf`, mejorando su comportamiento con `fd`, `bat` y `eza` para previsualización de archivos/directorios.
*   **`functions.sh`**: Contiene funciones avanzadas de shell, destacando `rcpp` (función potente para compilar/ejecutar proyectos C++), funciones para crear esqueletos de proyectos C++, `cleancpp`, `mkcd`, `findedit` (búsqueda de código con `rg` y `fzf`) y `tat` (gestión de sesiones de Tmux).
*   **`fish/`**: Configuración estructurada de Fish shell, incluyendo `config.fish` que establece configuraciones generales, colores para páginas `man`, variables de entorno, integración con Homebrew, `Starship` y `Zoxide`.
*   **`zsh/`**: El archivo `.zshrc` configura Zsh utilizando `Antigen` para una gestión extensa de plugins (incluyendo `oh-my-zsh`, varias integraciones de `fzf`, auto-sugerencias, etc.).

## Conclusión

El repositorio `dotfiles-2024` es un ejemplo de un entorno de desarrollo personal extremadamente sofisticado, altamente personalizado y bien diseñado. Muestra un enfoque modular, soporte multiplataforma, automatización extensa mediante scripts, un fuerte énfasis en la productividad (con herramientas CLI avanzadas) y una dedicación a un flujo de trabajo optimizado para el desarrollo de C++. La consistencia en los temas y la integración de herramientas en todas las aplicaciones y shells son notables.

## Repositorios de Referencia

*   [simple-hyprland](https://github.com/gaurav23b/simple-hyprland)

## 6. TODOs Pendientes

*   **Probar el Script de Post-Instalación en Arch Linux:** Ejecutar el script `bootstrap.sh` (o `os/linux/post-install-arch/install.sh` después de `chmod +x` manual) en una instalación limpia de Arch Linux (preferiblemente en una VM) para verificar que todos los paquetes se instalen correctamente y que los dotfiles se enlacen adecuadamente, y que el entorno Hyprland funcione como se espera.
