function lg {
    lazygit
}

function gcl{
  param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$repoNameGit
  )
  git clone $repoNameGit
}

function ga{
  param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$files
  )
  git add $files
}

function gaa {
  git add -A
}

function gacm {
  param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$message
  )
  git add .
  git commit -m $message
}

function gc {
  param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$args
  )
  git commit $args
}

function gcm {
  param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$message
  )
  git commit -m $message
}

function gcam {
  param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$message
  )
  git commit --amend -m $message
}

function gco {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git checkout $args
}

function gcob {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$branch
    )
    git checkout -b $branch
}

function gcp {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git cherry-pick $args
}

function gd {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git diff $args
}

function gds {
    git diff --staged
}

function gf {
    git fetch --all -p
}

function gs {
    git status
}

function gss {
    git status -sb
}

function grb {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git rebase $args
}

function grb3 {
    git rebase -i HEAD~3
}

function grb5 {
    git rebase -i HEAD~5
}

function gps {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git push $args
}

function gpsf {
    git push --force
}

function gpl {
    git pull --rebase --autostash
}

function gpp {
    git pull
    git push
}

function gm {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git merge $args
}

function gb {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    git branch $args
}

function gbr {
    git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) - <%(authorname)>' --sort=-committerdate
}

function gl {
    git --no-pager log --graph --pretty=oneline --abbrev-commit --decorate --all
}

function glg {
    git log --graph --all --abbrev-commit --date=relative --pretty=format:'%C(yellow)%h%C(reset) -%C(red)%d%C(reset) %s %C(green)(%ar) %C(bold blue)<%an>%C(reset)'
}