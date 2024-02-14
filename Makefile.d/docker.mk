DOCKER_COMPOSE := docker-compose -f deployments/$(ENVIRONMENT)/docker-compose.yml --env-file $(ENV_FILE)

# ==================================================
# .TARGET: docker
# ==================================================
.PHONY: build build/% run run/% up up/% exec exec/% down down/% logs log log/%

build: build/$(SERVICE)
build/%: $(ENV_FILE) # build or rebuild a image
	$(DOCKER_COMPOSE) build $*

run: run/$(SERVICE)
run/%: $(ENV_FILE) # run a one-off command on a container
	$(DOCKER_COMPOSE) run --rm $* sh -c 'bash || sh'

exec: exec/$(SERVICE)
exec/%: $(ENV_FILE) # run a command in a running container
	$(DOCKER_COMPOSE) exec $* sh -c 'bash || sh'

up: $(ENV_FILE) # create and start containers, networks, and volumes
	$(DOCKER_COMPOSE) up -d
up/%: $(ENV_FILE) # create and start a container
	$(DOCKER_COMPOSE) up -d $*

down: $(ENV_FILE) # stop and remove containers, networks, images, and volumes
	$(DOCKER_COMPOSE) down
down/%: $(ENV_FILE) # stop and remove a container
	$(DOCKER_COMPOSE) rm -fsv $*

logs: $(ENV_FILE) # view output from containers
	$(DOCKER_COMPOSE) logs -f

log: log/$(SERVICE)
log/%: $(ENV_FILE) # view output from a container
	$(DOCKER_COMPOSE) logs -f $*
