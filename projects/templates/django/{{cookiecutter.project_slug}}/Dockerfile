FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements/local.txt /app/requirements.txt
COPY requirements/base.txt /app/base.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

CMD ["python", "src/manage.py", "runserver", "0.0.0.0:8000"]
