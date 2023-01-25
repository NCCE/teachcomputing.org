# NCCE

## Behaviour

[Partners API integration](./doc/partners_api_integration.md)

## Development

IMPORTANT: Checkout this branch to a folder named `teachcomputing` with `git clone git@github.com:NCCE/teachcomputing.org.git teachcomputing` (one or two scripts right now expect the docker project name to be `teachcomputing`, so for now this is the easiest approach)

### Dependencies

- [Homebrew](https://brew.sh/)
- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox) > v4.0 (with support for `docker compose`)
- Python 2.7 (not 3.x yet)

### Setup

Stop any other web servers running on port 80.

To stop puma-dev with homebrew's lunchy comand
```
lunchy stop io.puma.dev
```

This script builds the docker image, sets up environment variables and adds a nicer local hostname:

```
sh ./scripts/setup.sh
```

In order for OAuth to work with STEM you will need to make sure you have an `id` and `secret` set. You get these from [here](https://github.com/NCCE/private-documentation/blob/master/OAuth2/stem-oauth2.md).

If you want to skip the OAuth flow you can set `BYPASS_OAUTH` to `true` in your `.env` file. This will log you in as `web@teachcomputing.org`.

### Dynamics (referred to in the codebase as Achiever for historic reasons)

By default the development environment expects to be able to communicate with Stem's staging Dynamics API which is used to populate the course list, and user enrolments etc. You'll need to add staging credentials to `.env` (find in the nonprod section of the heroku project in the terraform repo, or in RPF's lastpass: TC Achiever creds):

```
# STAGING
ACHIEVER_V2_PASSWORD=...
ACHIEVER_V2_USERNAME=...
ACHIEVER_V2_ENDPOINT=...
```

If your IP address is whitelisted, set `PROXY_URL=''` in `.env`. If not, you will need to ensure you have a proxy setup that tunnels to a whitelisted IP. You can do this [here](https://github.com/NCCE/private-documentation/blob/master/APIs/rpf-proxy.md)

There are two commands `yarn start-tunnel` and `yarn stop-tunnel` that are wrappers to manage the proxy locally, `yarn start` (below) utilises this to create the tunnel when the stack is brought up. It is important to have this setup for testing, however please see the 'Offline Dynamics' section below for how to run this offline.

### Starting and stopping the stack

Start the stack (this automatically creates the ssh tunnel and waits until the stack is ready to use):


```
yarn start
```

The app is then available at: http://teachcomputing.rpfdev.com

Stop the stack (this also gracefully closes the tunnel):

```
yarn stop
```


Sidekiq is used to process background jobs. You can view the admin UI for this by visiting `/admin/sidekiq` and using GSuite account to authenticate.

### Offline Dynamics

To develop offline, removing the need for the proxy and a third party API, you can set the following environment variables in your `.env`:

```
ACHIEVER_USE_LOCAL_TEMPLATES=true
ACHIEVER_LOCAL_TEMPLATE_PATH='spec/support/achiever/local_templates'
```

Data already exists in the path defined above, but it can be moved if you prefer.

This is useful if you want to create your own test data, for example by changing the data in the `coursesforcurrentdelegatebyprogramme.json` and linking the `stem_achiever_contact_no` to your local user and updating the `COURSETEMPLATENO`, you could generate enrolments in order to test course bookings (without this the test data needs to exist in Stem's API).

A task has been created to refresh this data from the api, run this with:

`yarn run exec rake achiever:refresh_local_templates`

### Database

The database is automatically setup the first time the container is run, and a migration is performed on each subsequent run.

#### Reset the database

```
yarn run reset-db
```

#### Run migrations

To perform migrations manually (without restarting the container) run:

```
yarn run web rails db:migrate
```

#### Seeding the database

To seed manually run:

```
yarn run web rails db:seed
```

### Install new Dependencies / Updates

The bundle has now been moved to a separate volume and once the initial build has taken place the bundle directory is mapped to a volume and persisted.

To install/update a new gem, first update the Gemfile and run

```
yarn run web bundle install
```

### Previews

Components etc. can be rendered using the local/review/staging app urls:

- http://teachcomputing.rpfdev.com/rails/components
- http://teachcomputing.rpfdev.com/rails/mailers

## Testing

Uses [rspec](https://github.com/rspec/rspec)

```
yarn test
```

To use [guard](https://github.com/guard/guard) to watch the tests:


```
yarn run guard
```

## Sitemaps

Sitemaps are generated via `sitemap:refresh`, which is managed by a scheduled task on Heroku. They can be found in the `public` directory.

## Tooling

### ERB Lint

Used for linting ERB / HTML files

Run with `yarn run exec erblint --lint-all`

https://github.com/Shopify/erb-lint

### Reek

Used for detecting 'code smell' in your app.

Run with `yarn run exec reek`

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

### ERD generation

`erd.pdf` will be [generated automatically whenever new migrations are run](https://github.com/voormedia/rails-erd#auto-generation).

To generate `erd.pdf` manually:

```
docker-compose run web bundle exec erd
```

### Troubleshooting

##### General
- `yarn start` will timeout if it fails to reach the site after a period of time, it will then output the docker logs so you can see the most recent output.
- If you can access the site at `localhost:3000` but not at `teachcomputing.rpfdev.com`, the nginx instance used by dev-nginx may have gone down, just run `dev-nginx restart` to bring it up again.

##### Turbolinks
Turbolinks was disabled because it stopped a bunch of critical page reporting and also download data from being captured. Avoid turning it back on.
Without turbolinks, this will break; the browser will complain that Turbolinks is missing:
```ruby
      redirect_to @foo, notice: 'Foo was successfully created.'
```
Resolve by removing `notice: 'Foo was successfully created.'`
