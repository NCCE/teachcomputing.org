#!/bin/bash
bin/rails db:migrate
bin/rails db:seed
bin/rake invalidate_cached_schema
if [ "$RAILS_ENV" == "production" ]; then
    bin/rails sitemap:refresh
elif [ "$RAILS_ENV" == "staging" ]; then
    bin/rails sitemap:refresh:no_ping
fi
