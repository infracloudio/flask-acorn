FROM --platform=$BUILDPLATFORM python:3.10-alpine AS builder

ENV FLASK_APP=flaskr
ENV FLASK_RUN_HOST 0.0.0.0

COPY . /app

WORKDIR /app

COPY requirements.txt /app
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

RUN flask init-db

# Unit tests
# RUN pip install pytest && pytest

EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]