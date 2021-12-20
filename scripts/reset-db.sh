#!/bin/bash
CONTAINER_NAME="db"
VOLUME_NAME="teachcomputing_pg-data"

docker compose stop
docker compose rm -f "$CONTAINER_NAME"
docker volume rm "$VOLUME_NAME" -f
docker compose up -d

docker compose run --rm --no-deps web rails db:migrate RAILS_ENV=test
