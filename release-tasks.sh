#!/bin/bash

bin/rails db:migrate
if [ "$RAILS_ENV" == "production" ]; then
    bin/rails sitemap:refresh
fi