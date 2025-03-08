# Directorios
$configPath = "$env:USERPROFILE\.config"
$workspacePath = "$env:USERPROFILE\workspace"
$reposPath = "$workspacePath\repos"
$dotfilesPath = "$reposPath\dotfiles-2024"
$gitConfigDotfilesPath = "$dotfilesPath\git\.gitconfig"
$starshipDotfilesPath = "$dotfilesPath\os\cross-platform\starship\starship.toml"
$wallpapersPath = "$reposPath\wallpapers"
$obsidianPath = "$reposPath\obsidian-notes"
$nvimPath = "$env:LOCALAPPDATA\nvim"

# Archivos u otros
$starshipPath = "$configPath\starship.toml"
$scoopExe = "$env:USERPROFILE\scoop\scoop.exe"
$gitConfig = "$env:USERPROFILE\.gitconfig"
$ahkFilePath = "$env:USERPROFILE\repos\dotfiles\os\windows\remap_keys\remap.ahk"

# Setup PowerShell profile
$profilePSDotfilesPath = "$dotfilesPath\os\window\programs\PowerShell\profiles\user_profile.ps1"
$powershellConfigPath= "$configPath\powershell"
$userProfileConfigPath = "$powershellConfigPath\user_profile.ps1"
$ProfilePSContent = ". $configPath\powershell\user_profile.ps1"

# Aplicaciones Scoop
$scoopApps = @(
  "7zip",
  # "autohotkey",
  # "bitwarden",
  "discord",
  "everything",
  "flow-launcher",
  "hoppscotch",
  "obsidian",
  "powershell",
  "postman",
  "vlc",
  "whatsapp",
  # "windows-terminal",
  # CLI
  "bat", # si la instala
  "cmake", # si la instala
  "curl",
  "delta", # si la instala
  "dotnet-sdk", # si la instala
  "docker", # si la instala
  "docker-compose", # si la instala
  "fnm", # si la instala
  "fzf", # si la instala
  "gcc",
  "gh", # si la instala
  "httpie",
  "jq", # si la instala
  "lazygit",
  "lazydocker", # si la instala
  "neovim", # si la instala
  "oh-my-posh", # si la instala
  "pnpm", # si la instala
  "posh-git",
  "posh-docker",
  "psfzf",
  "psreadline",
  "ripgrep", # si la instala
  "starship", # si la instala
  "sudo", # si la instala
  "terminal-icons",
  "z",
  # DataBases
  "postgresql", # si la instala
  "mongodb", # si la instala
  "tableplus",
  # IDEs
  "vscode",
  "rider",
  "pycharm",
  "clion",
  "webstorm",
  "datagrip",
  # browsers
  "firefox",
  "googlechrome",
  "brave",
  "edge"
  # nerdfonts
  "CascadiaCode-NF-Mono"
  "CascadiaMono-NF-Mono"
  "FiraCode-NF-Mono"
  "FiraMono-NF-Mono"
  "Hack-NF-Mono"
  "JetBrainsMono-NF-Mono"
  "Meslo-NF-Mono"
  "ZedMono-NF-Mono"
)