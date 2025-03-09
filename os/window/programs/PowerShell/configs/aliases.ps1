# System
Set-Alias -Name shutdown "shutdown.exe /s /t 0"
Set-Alias -Name restart "shutdown.exe /r /t 0"
Set-Alias -Name c clear
Set-Alias -Name x exit

# Useful shortcuts for traversing directories
Set-Alias -Name ".." "cd .."
Set-Alias -Name "..." "cd ..\.."
Set-Alias -Name "3." "cd ..\..\.."
Set-Alias -Name "4." "cd ..\..\..\.."
Set-Alias -Name "~" "cd $env:USERPROFILE"
# function .. { cd ..\ }
# function ... { cd ..\.. }
# function .... { cd ..\..\.. }
# function ..... { cd ..\..\..\.. }
# function ...... { cd ..\..\..\..\.. }

# Utils
Set-Alias -Name v nvim
Set-Alias -Name vi nvim
Set-Alias -Name vim nvim
Set-Alias -Name ll ls
Set-Alias -Name grep findstr
Set-Alias -Name cat bat
Set-Alias -Name ff fastfetch
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Git
Set-Alias -Name g git
Set-Alias -Name lg "lazygit"

# Docker
Set-Alias -Name d docker
Set-Alias -Name dc docker-compose
Set-Alias -Name ld lazydocker
