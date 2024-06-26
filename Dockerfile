FROM python:3.9-alpine3.13
LABEL maintainer="_dky"

ENV PYTHONUNBUFFERED 1

copy ./requirements.txt /tmp/requirements.txt
copy ./requirements.dev.txt /tmp/requirements.dev.txt
copy ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && /py/bin/pip install --upgrade pip && /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV="true" ] ; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        dj-user

ENV PATH="/py/bin:$PATH"

USER dj-user
