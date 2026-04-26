from .base import *
from .base import env

DEBUG = True
SECRET_KEY = env("DJANGO_SECRET_KEY", default="!!!SET-A-SECRET-KEY!!!")
ALLOWED_HOSTS = ["localhost", "0.0.0.0", "127.0.0.1"]

INSTALLED_APPS += ["debug_toolbar"]
MIDDLEWARE += ["debug_toolbar.middleware.DebugToolbarMiddleware"]

DEBUG_TOOLBAR_CONFIG = {
    "DISABLE_PANELS": ["debug_toolbar.panels.redirects.RedirectsPanel"],
    "SHOW_TEMPLATE_CONTEXT": True,
}

INTERNAL_IPS = ["127.0.0.1", "10.0.2.2"]
