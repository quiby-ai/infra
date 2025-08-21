PROJECT_DIR := $(CURDIR)
ENV_FILE    := $(PROJECT_DIR)/env/.env

COMPOSE_FILES = \
  -f $(PROJECT_DIR)/compose/traefik.yml \
  -f $(PROJECT_DIR)/compose/data.yml \
  -f $(PROJECT_DIR)/compose/apps.yml \
  -f $(PROJECT_DIR)/compose/redpanda.yml

DC = docker compose --project-directory $(PROJECT_DIR) --env-file $(ENV_FILE)

.PHONY: network up down pull deploy ps logs rollback

network:
	docker network inspect quiby_net >/dev/null 2>&1 || docker network create quiby_net

pull:
	$(DC) $(COMPOSE_FILES) pull

up: network
	$(DC) $(COMPOSE_FILES) up -d

down:
	$(DC) $(COMPOSE_FILES) down

ps:
	$(DC) $(COMPOSE_FILES) ps

logs:
	$(DC) $(COMPOSE_FILES) logs -f --tail=200

rollback:
	@[ -n "$(TAG)" ] || (echo "Usage: make rollback TAG=v1.2.3"; exit 1)
	sed -i.bak "s/:main/:$(TAG)/g" $(ENV_FILE)
	$(MAKE) deploy

deploy: pull up
	$(MAKE) ps
