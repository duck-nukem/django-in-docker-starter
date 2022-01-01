#!/bin/sh

until nc -z $DB_SERVICE_HOST $DB_SERVICE_PORT
do
    echo "Waiting for DB Connection..."
    sleep 1
done

python manage.py migrate
python manage.py collectstatic --no-input

python -m gunicorn \
app.asgi:application \
--workers $WEB_CONCURRENCY \
--worker-class uvicorn.workers.UvicornWorker \
--bind 0.0.0.0:8000