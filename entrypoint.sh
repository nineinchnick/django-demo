#!/usr/bin/env bash

set -e
set -x

if [ "$1" = "runserver" ]; then
    python manage.py migrate --noinput
    python manage.py runserver 0.0.0.0:8000
    exit 0
elif [ "$1" = "shell" ]; then
    python manage.py shell
    exit 0
elif [ "$1" = "uwsgi" ]; then
    uwsgi --chdir=/code --module=docker_demo.wsgi:application --master --pidfile=/tmp/project-master.pid --socket=0.0.0.0:${APP_PORT}
    exit 0
fi

exec "$@"
