# NCCE

## Development

### Dependencies:

- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox)

### Setup
```
cp .env-example .env
```

Build the containers:
```
docker-compose build
```

Start up all of the containers:
```
docker-compose up
```

Visit http://localhost:3000

### Install new Dependencies

Add the dependency to the Gemfile and run:
```
docker-compose run web bundle
```

Followed by:
```
docker-compose build
```

### Create Database
```
docker-compose run web bin/rails db:create
```

### Run migrations

After adding any new migrations they need to be run inside docker:
```
docker-compose run web bin/rails db:migrate
```

## Testing

Uses [rspec](https://github.com/rspec/rspec)
```
docker-compose run web bin/rspec
```

To use [guard](https://github.com/guard/guard) to watch the tests:
```
docker-compose run web bin/guard
```
