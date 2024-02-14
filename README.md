# fast-api-boilerplate-project

it's a simple and useful boilerplate for python projects using FastAPI framework

## Technology and Resources

- [Python 3.11](https://www.python.org/downloads/release/python-3110/) - **pre-requisite**
- [Docker](https://www.docker.com/get-started) - **pre-requisite**
- [Docker Compose](https://docs.docker.com/compose/) - **pre-requisite**
- [Poetry](https://python-poetry.org/) - **pre-requisite**
- [Ruff](https://github.com/astral-sh/ruff)
- [FastAPI](https://fastapi.tiangolo.com/)
- [Uvicorn](https://www.uvicorn.org/)

*Please pay attention on **pre-requisites** resources that you must install/configure.*

## How to install, run and test

### Environment variables

*Use this section to explain each env variable available on your application*

Variable | Description | Available Values | Default Value | Required
--- | --- | --- | --- | ---
ENV | The application enviroment |  `dev / test / qa / prod` | `dev` | Yes
PYTHONPATH | Provides guidance to the Python interpreter about where to find libraries and applications | [ref](https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH) | `.` | Yes

*Note: When you run the install command (using docker or locally), a .env file will be created automatically based on [env.template](env.template)*

Command | Docker | Locally | Description
---- | ------- | ------- | -------
install | `make docker/install` | `make local/install` | to install
tests | `make docker/tests` | `make local/tests` | to run the tests with coverage
lint | `make docker/lint` | `make local/lint` | to run static code analysis using ruff
lint/fix | `make docker/lint/fix` | `make local/lint/fix` | to fix files using ruff
run | `make docker/run` | `make local/run` | to run the project
build image | `make docker/image/build` | - | to build the docker image
push image | `make docker/image/push` | - | to push the docker image

**Helpful commands**

*Please, check all available commands in the [Makefile](Makefile) for more information*.

### Uvicorn settings

Uvicorn is an ASGI web server implementation for Python and you can [configure](https://www.uvicorn.org/settings/) it overriding these values on the [settings.conf](settings.conf) file.

Variable | Description | Available Values | Default Value | Required
--- | --- | --- | --- | ---
UVICORN_HOST | The host of the application |  `a valid host address` | `0.0.0.0` | Yes
UVICORN_PORT | The application port |  `a valid port number` | `8000` | Yes
UVICORN_WORKERS | The number of uvicorn workers |  `a valid number` | `dev` | No
UVICORN_ACCESS_LOG | Enable or disable the access log |  `True / False` | `True` | No
UVICORN_LOG_LEVEL | Set the log level |  `critical / error / warning / info / debug / trace'` | `info` | No

*Note: The default value of these configs are available on [run.py](run.py).*


## Logging

This project uses a simple way to configure the log with [logging.conf](logging.conf) to show the logs on the container output console.

## Settings

This project uses a simple way to manage the settings with [settings.conf](settings.conf) and [ConfigParser](https://docs.python.org/3/library/configparser.html) using a [config class](./src/config/settings.py).
