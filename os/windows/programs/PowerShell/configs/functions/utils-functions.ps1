# Navigate to x directory
function dev {
  cd "D:\Escritorio 2\Cursos-Yordy\00 - Cursos Programacion"
}
function ws {
  cd "$env:USERPROFILE\workspace"
}
function ii {
  cd "$env:USERPROFILE\workspace\ing-informatica"
}

#
function touch($file) {
  "" | Out-FIle $file -Encoding ASCII
}

function which($comand) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function mkcd {
  param (
    [string]$directory
  )
  if([string]::IsNullOrEmpty($directory)) {
    Write-Warning "Usage: mkcd <directory-name>"
    return
  }
  New-Item -ItemType Directory -Path $directory
  cd $directory
}
 function  eprofile {
  code "$env:USERPROFILE\.config\powershell\profiles\user_profile.ps1"
 }