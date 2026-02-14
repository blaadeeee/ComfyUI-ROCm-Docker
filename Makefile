.PHONY: build up down logs help

# Define default behavior
.DEFAULT_GOAL := start
start: build up logs

# Define variables
ARGS = $(filter-out $@,$(MAKECMDGOALS))
COMPOSE_FILE = docker-compose.yml
DOCKER_COMPOSE = docker compose

help: ## Display this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z_-]+:.*?## .*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}' | sed 's/^[ \t]*#//g'

build: ## Build the Docker images defined in the compose file
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

up: ## Start the containers in detached mode
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

down: ## Stop and remove containers, networks, and volumes
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --remove-orphans

logs: ## View logs for all services
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

sh: ## Open a shell in the within the specified service container. Usage: make sh SERVICE=<service_name>
	@if [ -z "$(SERVICE)" ]; then \
		echo "Error: SERVICE variable is not set. Usage: make sh SERVICE=<service_name>"; \
		exit 1; \
	fi
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec $(SERVICE) /bin/bash