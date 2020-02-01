# Starter project for Docker + Django + Postgres

## Important:

`SECRET_KEY` in `settings.py` is *EMPTY* - you must generate it. 

[Django SECRET_KEY](https://docs.djangoproject.com/en/2.2/ref/settings/#std:setting-SECRET_KEY)

## How to run:

Prerequisites: 
* [Docker](https://docs.docker.com/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

1. Clone this repo `git clone https://github.com/kreatemore/django-in-docker-starter.git <project_name>`
2. Change remote in git to point to your repo (or just reinit wit `git init`)
3. Generate your SECRET_KEY (example: https://djecrety.ir/)
4. `docker-compose up`
