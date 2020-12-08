#!/bin/bash

CONTAINER_NAME="db"
VOLUME_NAME="teachcomputingorg_pg-data"

docker-compose stop
docker-compose rm -f "$CONTAINER_NAME"
docker volume rm "$VOLUME_NAME" -f
docker-compose up -d
