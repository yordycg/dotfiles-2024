function pn {
  pnpm
}

function pni{
  pnpm install
}

function pna {
  param (
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$packages
  )
  pnpm add $packages
}

function pnad {
  param (
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$packages
  )
  pnpm add -D $packages
}

function pnrd {
  pnpm run dev
}
function pnrs {
  pnpm run start
}
function pnrb {
  pnpm run build
}