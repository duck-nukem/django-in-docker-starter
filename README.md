# Starter project for Docker + Django + Postgres + nginx
![CI](https://github.com/kreatemore/django-in-docker-starter/workflows/Build/badge.svg)

This is a common configuration I had to set up every time I wanted to start a new django project. 

I did this for myself, now it's yours to use ✨

## Important:

`SECRET_KEY` in `settings.py` is now a random 64 char long string. It'll be regenerated every time Django starts. You might want to set it to a fix value.

[Django SECRET_KEY](https://docs.djangoproject.com/en/2.2/ref/settings/#std:setting-SECRET_KEY)

## How to run:

Prerequisites: 
* [Docker](https://docs.docker.com/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

1. Clone this repo `git clone https://github.com/kreatemore/django-in-docker-starter.git <project_name>`
2. Change remote in git to point to your repo (or just reinit wit `git init`)
3. Generate your SECRET_KEY (example: https://djecrety.ir/)
4. `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up web`
5. A django app is now running @ http://localhost:8080/

If you're using PyCharm, you can configure the "app" service (from `docker-compose.yml`) to be the project interpreter.
This way debugging Django from the IDE will replace the running "app" instance with the one with your debug session.

## Structure

* `src` contains your django application. It also has a `bin` folder for
scripts you might want to run (even in prod)
* `web` contains a sample `nginx.conf` file, and a `static` folder where you can put
your js/css/whatever files.

For static files defined in the Django app, the path will be `server/static/resource.ext` (`/static` is defined in `settings.py`).
For all other assets, it'll be the subfolder names only in `web/static`. 
Example: js files will be `server/js/hello.js` not `server/static/hello.js` nor `sever/static/js/hello.js`
