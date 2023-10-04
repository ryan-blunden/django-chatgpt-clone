FROM python:3.11-slim-buster as builder

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3-dev libpq-dev gcc

COPY requirements/ requirements/
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements/production.txt

FROM python:3.11-slim-buster

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1 

WORKDIR /usr/src/app

COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/*

COPY . .

EXPOSE 8000

CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
