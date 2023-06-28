# Django ChatGPT Clone

Django version of the [chatgpt-clone](https://github.com/xtekky/chatgpt-clone).

[![Built with Cookiecutter Django](https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg?logo=cookiecutter)](https://github.com/cookiecutter/cookiecutter-django/)
[![Black code style](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/ambv/black)

License: GPLv3

## Requirements

- Python 3.9+
- PostgreSQL
- Git
- Make
- [Doppler CLI](https://docs.doppler.com/docs/install-cli)
- OpenAPI API Key: [https://platform.openai.com/account/api-keys](https://platform.openai.com/account/api-keys)

## Doppler

TODO

## Local Development

1. Clone the [ChatGPT Clone Repo](https://github.com/ryan-blunden/django-chatgpt-clone):

```sh
git clone https://github.com/ryan-blunden/django-chatgpt-clone
```

2. Create the virtual environment (which includes installing dev dependencies):

```sh
make create-virtual-env
```

3. Activate virtual environment:

```sh
eval $(make virtual-env)
```

4. Initialize the database:

```sh
make init-local-db
```

5. Perform the required database migrations:

```sh
make migrations
```

6. Then run the server:

```sh
make server
```

### Optional: Local Development with TLS

To run the development server in TLS mode with a locally trusted certificate using `mkcert`:

1. Add the `chatgptclone.local` host to your hosts file:

```sh
echo -e "\n127.0.0.1\tchatgptclone.local" | sudo tee -a /etc/hosts > /dev/null
```

2. Install mkcert by running

```sh
brew install mkcert
```

```sh
mkcert -install
```

3. Generate the TLS certificate:
  
```sh
mkcert chatgptclone.local
```
  
This will generate two files: `chatgptclone.local.pem` (certificate) and `chatgptclone.local-key.pem` (private key), both signed by the local CA.

4. Then run the server:

```sh
make server-tls
```

## Settings

Moved to [settings](http://cookiecutter-django.readthedocs.io/en/latest/settings.html).

## Basic Commands

### Setting Up Your Users

- To create a **normal user account**, just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.

- To create a **superuser account**, use this command:

      $ python manage.py createsuperuser

For convenience, you can keep your normal user logged in on Chrome and your superuser logged in on Firefox (or similar), so that you can see how the site behaves for both kinds of users.

### Type checks

Running type checks with mypy:

    $ mypy chatgpt_clone

### Test coverage

To run the tests, check your test coverage, and generate an HTML coverage report:

    $ coverage run -m pytest
    $ coverage html
    $ open htmlcov/index.html

#### Running tests with pytest

    $ pytest

### Sentry

Sentry is an error logging aggregator service. You can sign up for a free account at <https://sentry.io/signup/?code=cookiecutter> or download and host it yourself.
The system is set up with reasonable defaults, including 404 logging and integration with the WSGI application.

You must set the DSN url in production.

## Deployment

The following details how to deploy this application.

### Heroku

See detailed [cookiecutter-django Heroku documentation](http://cookiecutter-django.readthedocs.io/en/latest/deployment-on-heroku.html).
