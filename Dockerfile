ARG VERSION=latest

FROM alpine:${VERSION}
LABEL maintainer="author <author@github.com>"

RUN apk update \
    && apk add --no-cache tini tzdata

ENTRYPOINT ["/sbin/tini", "--"]
