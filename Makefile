PROJECT=quiby

ENVFILE=--env-file env/.env

COMPOSE= \
  -f compose/traefik.yml \
  -f compose/data.yml \
  -f compose/apps.yml \
  -f compose/redpanda.yml

.PHONY: network up down pull deploy ps logs

network:
	docker network inspect quiby_net >/dev/null 2>&1 || docker network create quiby_net

up: network
	docker compose $(ENVFILE) $(COMPOSE) up -d

down:
	docker compose $(ENVFILE) $(COMPOSE) down

pull:
	docker compose $(ENVFILE) $(COMPOSE) pull

deploy: pull up
	docker compose $(ENVFILE) $(COMPOSE) ps

ps:
	docker compose $(ENVFILE) $(COMPOSE) ps

logs:
	docker compose $(ENVFILE) $(COMPOSE) logs -f --tail=200

rollback:
	@[ -n "$(TAG)" ] || (echo "Usage: make rollback TAG=v1.2.3"; exit 1)
	sed -i.bak "s/:main/:$(TAG)/g" env/.env
	make deploy
