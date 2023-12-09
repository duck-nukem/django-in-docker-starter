FROM python:3.12-slim-bullseye AS build

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libpython3-dev \
        libpq-dev \
        gcc && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY src /opt/app
WORKDIR /opt/app

RUN pip install -r /opt/app/requirements.txt

FROM python:3.12-alpine3.17 as runtime

RUN python -m pip install "psycopg[binary,pool]"

COPY --from=build /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=build /opt/app/ /opt/app/

WORKDIR /opt/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONPATH /opt/app:$PYTHONPATH
