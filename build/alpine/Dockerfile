ARG OS_VERSION=latest

FROM alpine:$OS_VERSION
LABEL maintainer="kaduhiro <github@kaduhiro.com>"

RUN apk update \
    && apk add --no-cache tini tzdata

ENTRYPOINT ["/sbin/tini", "--"]
