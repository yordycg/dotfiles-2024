#!/usr/bin/env fish

# --- [py] Auto-activate Python Virtual Environment (.venv) ---
# Event listener for PWD changes.

function __venv_auto_activate --on-variable PWD
    # If a virtualenv is active and we moved out of its root, deactivate.
    if set -q VIRTUAL_ENV
        set -l venv_dir (dirname $VIRTUAL_ENV)
        if not string match -q "$venv_dir*" "$PWD"
            deactivate
        end
    end

    # If we are NOT in a virtualenv and a .venv exists, activate it.
    if not set -q VIRTUAL_ENV
        if test -d ".venv"
            if test -f ".venv/bin/activate.fish"
                source .venv/bin/activate.fish
            end
        end
    end
end

# Run once on startup in case we are already in a directory with .venv
__venv_auto_activate
