#!/bin/bash

python manage.py migrate
python manage.py collectstatic --no-input
uvicorn app.asgi:application --host app --port 8000 --reload
