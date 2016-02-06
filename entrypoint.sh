#!/usr/bin/env bash

set -e

#python manage.py migrate --noinput
#python manage.py collectstatic --noinput

if [ "$1" = "runserver" ]; then
    python manage.py runserver 0.0.0.0:8000
fi

exec "$@"