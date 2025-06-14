# verifying which docker compose command is available
ifneq (, $(shell which docker-compose))
    DOCKER_COMPOSE = docker-compose
else ifneq (, $(shell which docker))
    DOCKER_COMPOSE = docker compose
else
    $(error "Neither docker-compose nor docker compose is available")
endif

# loading and exporting all env vars from .env file automatically
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

APP_NAME="fast-api-boilerplate-project"
IMAGE_NAME="fast-api-boilerplate-project"
VERSION="latest"
MAIN_ENTRYPOINT="run.py"

################################
# COMMANDS TO RUN LOCALLY
################################

local/install: generate-default-env-file
	poetry install

local/activate:
	poetry env activate

local/tests:
	poetry run pytest -s --cov-report=html --cov-report xml:coverage.xml --cov-report=term --cov .

local/lint:
	poetry run ruff check .

local/lint/fix:
	poetry run ruff check --fix

local/run:
	poetry run python ${MAIN_ENTRYPOINT}

############################################
# COMMANDS TO RUN USING DOCKER (RECOMMENDED)
############################################

docker/install: generate-default-env-file
	$(DOCKER_COMPOSE) build ${APP_NAME}

docker/up: generate-default-env-file
	$(DOCKER_COMPOSE) up -d

docker/down:
	$(DOCKER_COMPOSE) down --remove-orphans

docker/test:
	$(DOCKER_COMPOSE) run ${APP_NAME} poetry run pytest --cov-report=html --cov-report xml:coverage.xml --cov-report=term --cov .

docker/lint:
	$(DOCKER_COMPOSE) run ${APP_NAME} poetry run ruff check .

docker/lint/fix:
	$(DOCKER_COMPOSE) run ${APP_NAME} poetry run ruff check --fix

docker/run:
	$(DOCKER_COMPOSE) run --service-ports ${APP_NAME} poetry run python ${MAIN_ENTRYPOINT}

##########################################
# COMMANDS TO RUN MIGRATIONS USING ALEMBIC
##########################################
migration/apply: local/activate
	poetry run alembic upgrade head

migration/downgrade: local/activate
	poetry run alembic downgrade -1

migration/revision: local/activate
	poetry run alembic revision --autogenerate -m "$(message)"

####################################
# DOCKER IMAGE COMMANDS
####################################

docker/image/build:
	docker build . --target production -t ${IMAGE_NAME}:${VERSION}

docker/image/push:
	docker push ${IMAGE_NAME}:${VERSION}

##################
# HEPFUL COMMANDS
##################

generate-default-env-file:
	@if [ ! -f .env ]; then cp env.template .env; fi;
