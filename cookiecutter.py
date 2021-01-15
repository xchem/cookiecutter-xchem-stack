from cookiecutter.main import cookiecutter
from django.utils.crypto import get_random_string

cookiecutter(
    'cookiecutter-xchem-stack',
    extra_context={'secretkey': get_random_string(50)}
)
