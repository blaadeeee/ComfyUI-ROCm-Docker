.PHONY: help build up down logs sh

# Define default behavior
.DEFAULT_GOAL := start

# Define variables
COMPOSE_FILE = docker-compose.yml
DOCKER_COMPOSE = docker-compose

help: ## Display this help message
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z_-]+:.*?## .*$$)|(^##)' $(MAKEFILE_LIST) \
		| sed 's/^[ \t]*#//' \
		| awk 'BEGIN {FS = ":.*?## "} {printf "  %-8s %s\n", $$1, $$2}' \
		| sort

start: build up logs ## Build and start ROCm/ComfyUI container and view logs [default target]

build: ## Build ROCm/ComfyUI container
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build --no-cache

up: ## Start ROCm/ComfyUI container in detached mode
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

down: ## Stop and remove ROCm/ComfyUI container
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down --remove-orphans

logs: ## Attach to ROCm/ComfyUI container logs (must be running)
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f rocm-comfyui

sh: ## Open a shell within ROCm/ComfyUI container (must be running)
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec rocm-comfyui /bin/bash