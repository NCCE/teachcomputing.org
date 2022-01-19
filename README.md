# NCCE

## Behaviour

[Partners API integration](./doc/partners_api_integration.md)

## Development

### Dependencies:

- [Homebrew](https://brew.sh/)
- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox) > v4.0 (with support for `docker compose`)
- asdf (`brew install asdf`)

### Setup

Install the depedencies in `.tool-versions`:

```
asdf install
```

Builds the docker image, sets up environment variables and adds nicer a local hostname:

```
yarn run setup
```

In order for OAuth to work with STEM you will need to make sure you have an `id` and `secret` set. You get these from [here](https://github.com/NCCE/private-documentation/blob/master/OAuth2/stem-oauth2.md).

If you want to skip the OAuth flow you can set `BYPASS_OAUTH` to `true` in your `.env` file. This will log you in as `web@raspberrypi.org`.

Optionally set a password for postgres by updating the value for `DEV_PASS` in your `.env` file.

### Starting and stopping the stack

Start the stack:

```
docker compose up -d
```

Or (this automatically creates the ssh tunnel and waits until the stack is ready to use):

```
yarn start
```

The app is available at: http://teachcomputing.rpfdev.com

Stop the stack:

```
docker compose down
```

Or (this also gracefully closes the tunnel):

```
yarn stop
```

In order to access the achiever API you will need to ensure you have a proxy setup. You can do this [here](https://github.com/NCCE/private-documentation/blob/master/APIs/rpf-proxy.md)

Sidekiq is used to process background jobs. You can view the admin UI for this by visiting `/admin/sidekiq` and using GSuite account to authenticate.

### Database

The database is automatically setup the first time the container is run, and a migration is performed on each subsequent run.

#### Reset the database

```
yarn run reset-db
```

#### Run migrations

To perform migrations manually (without restarting the container) run:

```
yarn run exec rails db:migrate
```

#### Seeding the database

To seed manually run:

```
yarn run exec rails db:seed
```

### Install new Dependencies / Updates

The bundle has now been moved to a separate volume and once the initial build has taken place the bundle directory is mapped to a volume and persisted.

To install/update a new gem, first update the Gemfile and run `bundle install` or `bundle update` locally then:

```
yarn run bundle-install
```

To reinstall all packages:

```
docker compose build
```

## Testing

Uses [rspec](https://github.com/rspec/rspec)

```
docker compose run --rm web bin/rspec
```

Or

```
yarn test
```

To use [guard](https://github.com/guard/guard) to watch the tests:

```
docker compose run --rm web bin/guard
```

Or

```
yarn run exec guard
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

`ruby-debug-ide` is enabled and waiting for connections by default on port `1234`. There is a `launch.json` in the repo and if you're using vscode it should be as easy as going to the 'Run' view, selecting 'Rails Debug' and clicking the green Run button. It's important to note that if you attempt to restart or stop the debug process, this will effectively kill the container, and a `docker compose up -d` will be necessary to continue - however this is rarely necessary in general use since you'll be debugging individual requests.

Calling `yarn run rspec-debug <path to spec>` will start an rspec debug session, this session will wait for a connection on `127.0.0.1:1235`. Add any breakpoints required, then for VSCode there is a launch configuration in `launch.json` called 'RSpec Debug', starting this will glom onto the previously started debug session.

If you prefer to use `byebug` you'll _first_ need to attach to the container which can be done with the command: `docker attach teachcomputingorg_web_1` (the container name can be checked with `docker compose ps`, but mostly it'll be the one here), then add your breakpoint and trigger your request. Again ending the session by quitting byebug or hitting `ctrl+c` will kill the container, so you'll need to run `docker compose up -d` again.

Set `OAUTH_DEBUG=true` in your `.env` file for more useful OAUTH logging.

### User Impersonation

When debugging it is sometimes desirable to see the site from a users perspective.
To do so without needing to change password you can set the `USER_TO_IMPERSONATE` environment variable in the `.env` file to the desired users ID.

### Troubleshooting

- `yarn start` will timeout if it fails to reach the site after a period of time, it will then output the docker logs so you can see the most recent output.
- If you can access the site at `localhost:3000` but not at `teachcomputing.rpfdev.com`, the nginx instance used by dev-nginx may have gone down, just run `dev-nginx restart` to bring it up again.
