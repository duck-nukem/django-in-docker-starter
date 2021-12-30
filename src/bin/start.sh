#!/bin/sh

until nc -zv $DB_SERVICE_HOST $DB_SERVICE_PORT
do
    echo "Waiting for DB Connection..."
    sleep 3
done

python manage.py migrate
python manage.py collectstatic --no-input
python -m uvicorn app.asgi:application --host 0.0.0.0 --port 8000 --reload