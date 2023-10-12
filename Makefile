.ONESHELL:

include .env .env.local

ENV_FILE := .env.app

$(ENV_FILE): .env .env.local
	cat .env .env.local > $(ENV_FILE)

DOCKER_COMPOSE := docker-compose -f deployments/$(ENVIRONMENT)/docker-compose.yml --env-file $(ENV_FILE)

# ==================================================
# .TARGET: general
# ==================================================
.PHONY: help clean

help: $(ENV_FILE) # list available targets and some
	@len=$$(awk -F':' ' \
		BEGIN {m = 0;} \
		/^[^\s]+:/ { \
			gsub(/%/, "<service>", $$1); \
			l = length($$1); \
			if(l > m) { \
				m = l; \
			} \
		} \
		END {print m;}' $(MAKEFILE_LIST)) \
	&& printf \
		"%s%s\n\n%s\n%s\n\n%s\n%s\n" \
		"usage:" \
		"$$(printf " make <\033[1mtarget\033[0m>")" \
		"services:" \
		"$$($(DOCKER_COMPOSE) config --services | awk '{ $$1 == "$(SERVICE)" ? x = "*" : x = " "; } { printf("  \033[1m[%s] %s\033[0m\n", x, $$1); }')" \
		"targets:" \
		"$$(awk -F':' ' \
			function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; } \
			function rtrim(s) { sub(/[ \t\r\n]+$$/, "", s); return s; } \
			function trim(s)  { return rtrim(ltrim(s)); } \
			$$1 ~ /^#+[ \t]+\.TARGET$$/ { \
				target = trim($$2); printf("  \033[2;37m%s:\033[m\n", target); \
			} \
			/^[^ \t]+:/ { \
				gsub(/%/, target == "docker" ? "[service]" : "**", $$1); \
				gsub(/^[^#]+/, "", $$2); \
				gsub(/^[# \t]+/, "", $$2); \
				if ($$2) { \
					printf "    \033[1m%-'$$len's\033[0m  %s\n", $$1, $$2; \
				} \
			} \
			' $(MAKEFILE_LIST) \
		)"

clean: # remove cache files from the working directory

# ==================================================
# .TARGET: docker
# ==================================================
.PHONY: build build/% run run/% exec exec/% up up/%  down down/% logs log log/%

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

logs: # view output from containers
	$(DOCKER_COMPOSE) logs -f

log: log/$(SERVICE)
log/%: # view output from a container
	$(DOCKER_COMPOSE) logs -f $*

