# GitHub CLI functions for PowerShell

# Repository functions
function ghr {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo $args
}

function ghrc {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo create $args
}

function ghrl {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo list $args
}

function ghrf {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo fork $args
}

function ghrv {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo view $args
}

function ghrw {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh repo view -w $args
}

# Pull Request functions
function ghpr {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr $args
}

function ghprc {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr create $args
}

function ghprl {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr list $args
}

function ghprv {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr view $args
}

function ghprco {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr checkout $args
}

function ghprm {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh pr merge $args
}

# Issue functions
function ghi {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh issue $args
}

function ghic {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh issue create $args
}

function ghil {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh issue list $args
}

function ghiv {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh issue view $args
}

# Gist functions
function ghg {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh gist $args
}

function ghgc {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh gist create $args
}

function ghgl {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh gist list $args
}

# Release functions
function ghra {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh release $args
}

function ghrac {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh release create $args
}

function ghral {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh release list $args
}

# Workflow functions
function ghw {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh workflow $args
}

function ghwl {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh workflow list $args
}

function ghwr {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh workflow run $args
}

# Auth functions
function ghauth {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$args
    )
    gh auth $args
}

function ghauthstatus {
    gh auth status
}

# Convenience functions
function ghbrowse {
    gh repo view --web
}

function ghclone {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$repo
    )
    # Support for shorthand notation (username/repo)
    if ($repo -notlike "https://*" -and $repo -notlike "git@*") {
        if ($repo -notlike "*//*") {
            $repo = "https://github.com/$repo"
        }
    }

    git clone $repo
}