FROM python:3.7-slim-buster AS build

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt update && apt install -y \
        libpython3.7 \
        libpq-dev \
        gcc

RUN pip install --upgrade pip

COPY src /opt/app

WORKDIR /opt/app
RUN pip install -r /opt/app/requirements.txt

FROM gcr.io/distroless/python3

# Enable this to allow PyCharm to generate skeletons properly
#COPY --from=build /bin/ /bin/

# dependencies for psycopg2
COPY --from=build /lib/ /lib/
COPY --from=build /usr/lib/ /usr/lib/

# application and its dependencies
COPY --from=build /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
COPY --from=build /opt/app/ /opt/app/

ENV PYTHONPATH=/usr/local/lib/python3.7/site-packages

WORKDIR /opt/app

# Overwriting the default python entrypoint for better integration with tools (like IDEs)
ENTRYPOINT []
