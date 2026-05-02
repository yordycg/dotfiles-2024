# -----------------------------------------------------------------------------
# PNPM Specialized Functions
# -----------------------------------------------------------------------------

function pni  { pnpm install $args }
function pna  { pnpm add $args }
function pnad { pnpm add -D $args }
function pnx  { pnpm dlx $args }

# Scripts
function pnr  { pnpm run $args }
function pnrd { pnpm run dev $args }
function pnrs { pnpm run start $args }
function pnrb { pnpm run build $args }
function pnt  { pnpm test $args }

# Utils
function pnl  { pnpm list $args }
function pnu  { pnpm update $args }
