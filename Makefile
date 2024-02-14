.ONESHELL:

include .env .env.local

SHELL         := $(shell [ ! -e /.dockerenv ] && echo $$SHELL || ([ -x /bin/bash ] && echo /bin/bash || echo /bin/sh))
MAKEFILE_DIR  := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ENV_FILE     := .env.app

$(ENV_FILE): .env .env.local
	cat .env .env.local > $(ENV_FILE)

include $(wildcard Makefile.d/*.mk)
