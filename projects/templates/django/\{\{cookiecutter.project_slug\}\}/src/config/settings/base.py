import os
from pathlib import Path
import environ

# PATHS
# src/config/settings/base.py -> src/config/settings/ -> src/config/ -> src/ -> Root
BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
APPS_DIR = BASE_DIR / "src" / "apps"

env = environ.Env()
# Intentar leer .env desde la raíz
environ.Env.read_env(os.path.join(BASE_DIR, '.env'))

# GENERAL
DEBUG = env.bool("DJANGO_DEBUG", False)
TIME_ZONE = "America/Santiago"
LANGUAGE_CODE = "es-cl"
USE_I18N = True
USE_L10N = True
USE_TZ = True

# DATABASES
DATABASES = {
    "default": env.db("DATABASE_URL", default="sqlite:///db.sqlite3")
}
DATABASES["default"]["ATOMIC_REQUESTS"] = True

# URLS
ROOT_URLCONF = "config.urls"
WSGI_APPLICATION = "config.wsgi.application"

# APPS
DJANGO_APPS = [
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.admin",
    "django.contrib.messages",
    "django.contrib.staticfiles",
]
THIRD_PARTY_APPS = [
    "django_extensions",
]
LOCAL_APPS = [
    "apps.users", # Nuestra app personalizada de usuarios
]
INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

# AUTHENTICATION (Pro Standard: Custom User Model)
AUTH_USER_MODEL = "users.User"

# PASSWORDS
AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# STATIC & MEDIA
STATIC_URL = "/static/"
STATIC_ROOT = str(BASE_DIR / "staticfiles")
STATICFILES_DIRS = [str(BASE_DIR / "static")]

MEDIA_URL = "/media/"
MEDIA_ROOT = str(BASE_DIR / "media")

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [str(BASE_DIR / "templates")],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"
