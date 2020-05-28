FROM ruby:2.5.7-alpine
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs nodejs-npm chromium chromium-chromedriver
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY package.json package-lock.json ./
RUN npm i
COPY . /app
CMD ./scripts/docker-entrypoint.sh
