FROM python:3-alpine

RUN pip install --upgrade pip

COPY src /opt/app

WORKDIR /opt/app
RUN pip install -r requirements.txt

ENTRYPOINT python manage.py migrate && python manage.py runserver 0.0.0.0:8000