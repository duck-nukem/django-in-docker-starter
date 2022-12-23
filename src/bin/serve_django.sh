#!/bin/sh

until python -c 'import socket; import os; s = socket.socket(socket.AF_INET, socket.SOCK_STREAM); s.connect((os.environ["DB_SERVICE_HOST"], int(os.environ["DB_SERVICE_PORT"])))'
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