# Hello, World

Template for starting something new

## Requirement

* make
* docker
* docker-compose

## Usage

```
usage: make <target>

services:
  * service

targets:
  build/<service>   build or rebuild a image
  run/<service>     run a one-off command on a container
  exec/<service>    run a command in a running container
  up                create and start containers, networks, and volumes
  up/<service>      create and start a container
  down              stop and remove containers, networks, images, and volumes
  down/<service>    stop and remove a container
  logs              view output from containers
  log/<service>     view output from a container
  help              list available targets and some
  clean             remove cache files from the working directory
```
