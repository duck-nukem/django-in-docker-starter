FROM python:3-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache \
        gcc \
        libc-dev \
        make \
        musl-dev \
        postgresql-client \
        postgresql-dev

RUN pip install --upgrade pip

COPY src /opt/app

WORKDIR /opt/app
RUN pip install -r requirements.txt
