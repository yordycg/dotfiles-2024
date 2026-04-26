# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## Quick Start (Local)

1. **Setup Environment:**
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements/local.txt
   ```

2. **Database:**
   - Option A: Use Docker (`docker-compose up db`)
   - Option B: Use local DB (`db up postgres`)

3. **Migrations:**
   ```bash
   cd src
   python manage.py migrate
   python manage.py runserver
   ```
