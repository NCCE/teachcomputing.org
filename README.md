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

Start the web container:
```
docker-compose up web
```

Visit http://localhost:3000

If it's your first time running you'll need to create the database first before use. You'll also need to do this if you've removed your database volume.


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
