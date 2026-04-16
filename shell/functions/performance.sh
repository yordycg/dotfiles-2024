###############################################################################
# PERFORMANCE & LAZY LOADING
###############################################################################

# Lazy load FNM (Node Version Manager)
# Only initializes fnm when node, npm, npx, pnpm or fnm are actually called.
if command -v fnm >/dev/null 2>&1; then
  function fnm() {
    unset -f fnm node npm npx pnpm
    eval "$(fnm env --use-on-cd)"
    fnm "$@"
  }

  function node() {
    unset -f fnm node npm npx pnpm
    eval "$(fnm env --use-on-cd)"
    node "$@"
  }

  function npm() {
    unset -f fnm node npm npx pnpm
    eval "$(fnm env --use-on-cd)"
    npm "$@"
  }

  function npx() {
    unset -f fnm node npm npx pnpm
    eval "$(fnm env --use-on-cd)"
    npx "$@"
  }

  function pnpm() {
    unset -f fnm node npm npx pnpm
    eval "$(fnm env --use-on-cd)"
    pnpm "$@"
  }
fi

# Template for other tools (pyenv, sdkman, etc.)
# function pyenv() {
#   unset -f pyenv python pip
#   eval "$(pyenv init -)"
#   pyenv "$@"
# }
