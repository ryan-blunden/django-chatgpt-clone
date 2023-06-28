SHELL := /bin/bash
VENVDIR := ${HOME}/.virtualenvs
WORKDIR := django-chatgpt-clone
VENV := $(VENVDIR)/$(WORKDIR)/bin
PYTHON := $(VENV)/python
ACTIVATE :=$(VENV)/activate

create-virtual-env:
	mkdir -p "$(VENVDIR)" && \
	python3 -m venv $(VENVDIR)/$(WORKDIR) && \
	. $(ACTIVATE) && \
	pip install --upgrade pip setuptools && \
	pip install -r requirements/local.txt

virtual-env:
	. $(ACTIVATE)

init-local-db:
	psql postgres --file <(doppler secrets substitute utility/init-db.sql)

cleanup-local-db:
	psql postgres --file utility/cleanup-db.sql

mkcert:
	mkcert chatgptclone.local

super-user:
	doppler run -- ./manage.py createsuperuser

make-migrations:
	doppler run -- ./manage.py makemigrations

migrate:
	doppler run -- ./manage.py migrate

server:
	@doppler run --command='./manage.py runserver_plus $$HOST:$$PORT'

server-tls:
	@doppler run --command='./manage.py runserver_plus $$HOST:$$PORT --cert-file chatgptclone.local.pem --key-file chatgptclone.local-key.pem'

pylint:
	doppler run -- pylint --load-plugins pylint_django ./chatgpt_clone/

flake8:
	flake8

black:
	black ./

lint-js:
	npm run lint

prettier:
	npm run prettier
