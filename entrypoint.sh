#!/usr/bin/env bash

set -e
set -x

python manage.py migrate --noinput

if [ "$1" = "runserver" ]; then
    python manage.py runserver 0.0.0.0:8000
    exit 0
elif [ "$1" = "shell" ]; then
    python manage.py shell
    exit 0
fi

exec "$@"
