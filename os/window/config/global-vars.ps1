# Directorios
$configPath = "$env:USERPROFILE\.config"
$workspacePath = "$env:USERPROFILE\workspace"
$reposPath = "$workspacePath\repos"
$dotfilesPath = "$reposPath\dotfiles-2024"
$wallpapersPath = "$reposPath\wallpapers"
$obsidianPath = "$reposPath\obsidian-notes"
$nvimPath = "$env:LOCALAPPDATA\nvim"

# Archivos u otros
$gitConfigDotfilesPath = "$dotfilesPath\git\.gitconfig"
$gitConfigIPVGDotfilesPath = "$dotfilesPath\git\.gitconfig-ipvg"
$gitConfigPERSONALDotfilesPath = "$dotfilesPath\git\.gitconfig-personal"
$gitConfigWORKDotfilesPath = "$dotfilesPath\git\.gitconfig-work"
$gitConfig = "$env:USERPROFILE\.gitconfig"
$gitConfigIPVG = "$env:USERPROFILE\.gitconfig-ivpg"
$gitConfigPERSONAL = "$env:USERPROFILE\.gitconfig-personal"
$gitConfigWORK = "$env:USERPROFILE\.gitconfig-work"
$starshipDotfilesPath = "$dotfilesPath\os\cross-platform\starship\starship.toml"
$starshipPath = "$configPath\starship.toml"
$confWinTerminalDotfilesPath = "$reposPath\dotfiles-2024\os\window\programs\Windows-Terminal\settings.json"
$confWinTerminalPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

$scoopExe = "$env:USERPROFILE\scoop\scoop.exe"
$ahkFilePath = "$env:USERPROFILE\repos\dotfiles\os\windows\remap_keys\remap.ahk"

# Setup PowerShell profile
$profilePSDotfilesPath = "$dotfilesPath\os\window\programs\PowerShell\profiles\user_profile.ps1"
$powershellConfigPath = "$configPath\powershell"
$userProfileConfigPath = "$powershellConfigPath\user_profile.ps1"
$ProfilePSContent = ". $configPath\powershell\user_profile.ps1"

# Aplicaciones Scoop
$scoopApps = @(
  "7zip",
  "pwsh",
  "windows-terminal",
  # CLI
  "bat",
  "cmake",
  "curl",
  "curlie",
  "delta",
  "dotnet-sdk",
  "fnm",
  "fzf",
  "gcc",
  "gh",
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
  # nerdfonts
  "CascadiaCode-NF-Mono",
  "FiraCode-NF-Mono",
  "JetBrainsMono-NF-Mono",
  "Meslo-NF-Mono",
  "RobotoMono-NF-Mono"
)