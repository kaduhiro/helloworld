ARG OS_VERSION=latest

FROM ubuntu:$OS_VERSION
LABEL maintainer="kaduhiro <github@kaduhiro.com>"

RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends tini tzdata

RUN apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]
