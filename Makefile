DOCKER-COMPOSE = ./srcs/docker-compose.yml

all: up

set-dir:
	@sudo mkdir -p /home/${USER}/data/wordpress
	@sudo mkdir -p /home/${USER}/data/db


up: set-dir
	docker compose -f $(DOCKER-COMPOSE) up --build

down:
	docker compose -f ${DOCKER-COMPOSE} down

re: clean
	docker compose -f ${DOCKER-COMPOSE} up --build

clean: 	
	docker compose -f $(DOCKER-COMPOSE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	sudo rm -rf /home/${USER}/data/wordpress
	sudo rm -rf /home/${USER}/data/db
	@docker system prune --volumes --all --force
	@docker rm -q $$(docker ps -qa) 2> /dev/null || true
	@docker rmi -f $$(docker images -qa) 2> /dev/null || true
	@docker volume rm $$(docker volume ls -q) 2> /dev/null  || true

.PHONY: all re up down clean