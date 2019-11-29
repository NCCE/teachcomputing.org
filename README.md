# NCCE

## Development

### Dependencies:

- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox)

### Setup
```
cp .env-example .env
```

You'll need to set up the DB Connection ID and the relevant Workflow IDs. A list of env vars for Workflow IDs can be found [here](https://github.com/NCCE/private-documentation/blob/master/APIs/stem-achiever.md).

In order for OAuth to work with STEM you will need to make sure you have an `id` and `secret` set. You get these from [here](https://github.com/NCCE/private-documentation/blob/master/OAuth2/stem-oauth2.md).

If you want to skip the OAuth flow you can set `BYPASS_OAUTH` to `true` in your `.env` file. This will log you in as `web@raspberrypi.org`.

Build the containers:
```
docker-compose build
```

Start the web container:
```
docker-compose up web
```

Visit http://localhost:3000

If it's your first time running you'll need to create the database first before use. You'll also need to do this if you've removed your database volume.

In order to access the achiever API you will need to ensure you have a proxy setup. You can do this [here](https://github.com/NCCE/private-documentation/blob/master/APIs/rpf-proxy.md)

Sidekiq is used to process background jobs. You can view the admin UI for this by visiting `/admin/sidekiq` and using the credentials `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD`. Values for these can be found in the terraform repository.

### Create Database
```
docker-compose run --rm web bin/rails db:create
```

### Run migrations

After adding any new migrations they need to be run inside docker:
```
docker-compose run --rm web bin/rails db:migrate
```

### Install new Dependencies

Add the dependency to the Gemfile or package.json and run:
```
docker-compose down
docker-compose build
```

## Testing

Uses [rspec](https://github.com/rspec/rspec)
```
docker-compose run --rm web bin/rspec
```

To use [guard](https://github.com/guard/guard) to watch the tests:
```
docker-compose run --rm web bin/guard
```

## Sitemaps

Sitemaps are generated via `sitemap:refresh`, which is managed by a scheduled task on Heroku. They can be found in the `public` directory.

## Tooling

### ERB Lint

Used for linting ERB / HTML files

Run with `bundle exec erblint --lint-all`

https://github.com/Shopify/erb-lint
