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
$profilePSDotfilesPath = "$env:dotfilesPath\os\window\programs\PowerShell\profiles\user_profile.ps1"
$powershellConfigPath= "$configPath\powershell"
$userProfileConfigPath = "$powershellConfigPath\user_profile.ps1"
$ProfilePSContent = ". $configPath\powershell\user_profile.ps1"

# Aplicaciones Scoop
$scoopApps = @(
  "7zip",
  "autohotkey",
  "bitwarden",
  "discord",
  "everything",
  "flow-launcher",
  "hoppscotch",
  "obsidian",
  "powershell",
  "postman",
  "vlc",
  "whatsapp",
  "windows-terminal",
  # CLI
  "bat",
  "cmake",
  "curl",
  "delta",
  "dotnet-sdk",
  "docker",
  "docker-compose",
  "fnm",
  "fzf",
  "gcc",
  "gh",
  "httpie",
  "jq",
  "lazygit",
  "lazydocker",
  "neovim",
  "oh-my-posh",
  "pnpm",
  "posh-git",
  "posh-docker",
  "psfzf",
  "psreadline",
  "ripgrep",
  "starship",
  "sudo",
  "terminal-icons",
  "z",
  # DataBases
  "postgresql",
  "mongodb",
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