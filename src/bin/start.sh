#!/bin/sh

python manage.py migrate
python manage.py collectstatic --no-input
python -m uvicorn app.asgi:application --host app --port 8000 --reload