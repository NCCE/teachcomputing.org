# NCCE

## Development

### Dependencies:

- [Homebrew](https://brew.sh/)
- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox)
- Node & NPM

### Setup

Builds the docker image, sets up environment variables, and adds nicer a local hostname:
```
npm run setup
```

In order for OAuth to work with STEM you will need to make sure you have an `id` and `secret` set. You get these from [here](https://github.com/NCCE/private-documentation/blob/master/OAuth2/stem-oauth2.md).

If you want to skip the OAuth flow you can set `BYPASS_OAUTH` to `true` in your `.env` file. This will log you in as `web@raspberrypi.org`.

Optionally set a password for postgres by updating the value for `DEV_PASS` in your `.env` file.

### Starting and stopping the stack

Start the stack:
```
docker-compose up -d
```
Or (to automatically create an ssh tunnel, poll for the env to start and open a new tab):
```
npm start
```

Stop the stack:
```
docker-compose down
```
Or (to also gracefully close the tunnel)
```
npm stop
```

The app is available at: http://teachcomputing.rpfdev.com

In order to access the achiever API you will need to ensure you have a proxy setup. You can do this [here](https://github.com/NCCE/private-documentation/blob/master/APIs/rpf-proxy.md)

Sidekiq is used to process background jobs. You can view the admin UI for this by visiting `/admin/sidekiq` and using GSuite account to authenticate.

### Database

The database is automatically setup the first time the container is run, and a migration is performed on each subsequent run.

#### Reset the database

Since the setup is run via rails it's easiest to bring the entire stack down.
```
docker-compose down -v
docker-compose up -d
```

You can also target the db volume with the following, however you'll need to bring the web container down and up again too.
```
docker-compose rm -sv db
docker-compose down
docker-compose up -d
```

#### Run migrations

To perform migrations manually (without restarting the container) run:
```
docker-compose run --rm web bin/rails db:migrate
```

#### Seeding the database

To seed manually run:
```
docker-compose run web bin/rails db:seed
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
Or
```
npm test
```

To use [guard](https://github.com/guard/guard) to watch the tests:
```
docker-compose run --rm web bin/guard
```
Or
```
npm run guard
```

## Sitemaps

Sitemaps are generated via `sitemap:refresh`, which is managed by a scheduled task on Heroku. They can be found in the `public` directory.

## Tooling

### ERB Lint

Used for linting ERB / HTML files

Run with `bundle exec erblint --lint-all`

https://github.com/Shopify/erb-lint

### Reek

Used for detecting 'code smell' in your app.

Run with `bundle exec reek`

### Brakeman

Used for static code analysis to check for potential security flaws.

https://brakemanscanner.org/docs/quickstart/

We are ignoring some of the warnings using the method described in the [Brakeman docs](https://brakemanscanner.org/docs/ignoring_false_positives/) We are using the default location for the ignore file, etc.

Run `brakeman -I config/brakeman.ignore .` in the project root and follow the onscreen prompts, outlined in the above doc, to use the tool and check the output for warnings, etc.

### Debugging

`ruby-debug-ide` is enabled and waiting for connections by default on port `1234`. There is a `launch.json` in the repo and if you're using vscode it should be as easy as going to the 'Run' view, selecting 'Debug Attach' and clicking the green Run button. It's important to note that if you attempt to restart or stop the debug process, this will effectively kill the container, and a `docker-compose up -d` will be necessary to continue - however this is rarely necessary in general use since you'll be debugging individual requests.

If you prefer to use `byebug` you'll *first* need to attach to the container which can be done with the command: `docker attach teachcomputingorg_web_1` (the container name can be checked with `docker-compose ps`, but mostly it'll be the one here), then add your breakpoint and trigger your request. Again ending the session by quitting byebug or hitting `ctrl+c` will kill the container, so you'll need to run `docker-compose up -d` again.

Set `OAUTH_DEBUG=true` in your `.env` file for more useful OAUTH logging.

### Troubleshooting

> I've run `npm start` and it's hanging whilst 'Waiting for the stack to become available'

The script doesn't time out so this indicates that it can't resolve to `localhost:3000` and there was a problem bringing up the web container. Run `docker-compose logs web` to investigate the cause.

> I can access the site at `localhost:3000` but not at `teachcomputing.rpfdev.com`

In some circumstances the nginx instance used by dev-nginx may go down, just run `dev-nginx restart-nginx` to bring it up again.
