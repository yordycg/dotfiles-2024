# -----------------------------------------------------------------------------
# Git Specialized Functions
# -----------------------------------------------------------------------------

# Basics
function ga   { git add $args }
function gaa  { git add -A }
function gs   { git status $args }
function gss  { git status -sb }
function gd   { git diff $args }
function gds  { git diff --staged }
function gf   { git fetch --all -p }
function gl   { git log --graph --pretty=oneline --abbrev-commit --decorate --all }
function glg  { git log --graph --all --abbrev-commit --date=relative --pretty=format:'%C(yellow)%h%C(reset) -%C(red)%d%C(reset) %s %C(green)(%ar) %C(bold blue)<%an>%C(reset)' }

# Commit
function gc   { git commit $args }
function gcm  { git commit -m $args }
function gacm { git add -A; git commit -m $args }
function gcam { git commit --amend --no-edit $args }

# Branch & Checkout
function gco  { git checkout $args }
function gcob { git checkout -b $args }
function gb   { git branch $args }
function gbr  { git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) - <%(authorname)>' --sort=-committerdate }

# Push & Pull
function gps  { git push $args }
function gpsf { git push --force-with-lease }
function gpl  { git pull --rebase --autostash $args }
function gpp  { git pull; git push }

# Rebase & Merge
function grb  { git rebase $args }
function grbi { git rebase -i HEAD~$args }
function gm   { git merge $args }

# Utils
function gcl  { git clone $args }
function gclean { git branch --merged | ForEach-Object { if ($_ -notmatch "main|master|dev") { git branch -d $_.Trim() } } }
