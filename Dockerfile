FROM ruby:2.7.2-alpine
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs chromium chromium-chromedriver yarn
RUN apk --update add less
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle update --bundler
RUN bundle install
COPY package.json yarn.lock ./
RUN yarn
COPY . /app
CMD ./scripts/docker-entrypoint.sh
