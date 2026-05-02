# -----------------------------------------------------------------------------
# Python & Django Specialized Functions (Windows Port)
# -----------------------------------------------------------------------------

# Python Base
function py { python $args }

# Virtual Environments
function va { 
    if (Test-Path ".venv\Scripts\Activate.ps1") { . .venv\Scripts\Activate.ps1 }
    elseif (Test-Path "venv\Scripts\Activate.ps1") { . venv\Scripts\Activate.ps1 }
    else { Write-Warning "No virtual environment found in .venv or venv" }
}

function vd { if (Get-Command deactivate -ErrorAction SilentlyContinue) { deactivate } }

# Pip
function pi  { pip install $args }
function pir { pip install -r requirements.txt $args }
function pif { pip freeze > requirements.txt }

# Django (The 'pm' experience)
function pm   { python manage.py $args }
function pmr  { python manage.py runserver $args }
function pmm  { python manage.py migrate $args }
function pmmm { python manage.py makemigrations $args }
function pms  { python manage.py shell_plus $args }
function pmc  { python manage.py createsuperuser $args }
function pmt  { python manage.py test $args }

# Quality Tools
function rf   { ruff check --fix $args }
function rff  { ruff format $args }
function pt   { pytest $args }
