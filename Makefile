PROJECT=quiby

COMPOSE= \
  -f compose/traefik.yml \
  -f compose/data.yml \
  -f compose/apps.yml \
  -f compose/redpanda.yml

.PHONY: network up down pull deploy ps logs

network:
	docker network inspect quiby_net >/dev/null 2>&1 || docker network create quiby_net

up: network
	docker compose $(COMPOSE) up -d

down:
	docker compose $(COMPOSE) down

pull:
	docker compose $(COMPOSE) pull

deploy: pull up
	docker compose $(COMPOSE) ps

ps:
	docker compose $(COMPOSE) ps

logs:
	docker compose $(COMPOSE) logs -f --tail=200

rollback:
	@[ -n "$(TAG)" ] || (echo "Usage: make rollback TAG=v1.2.3"; exit 1)
	sed -i.bak "s/:main/:$(TAG)/g" env/.env
	make deploy
