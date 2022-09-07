FROM ruby:2.7.2-alpine
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs chromium chromium-chromedriver python3 python3-dev py3-pip yarn git procps
RUN apk --update add less
RUN pip install --upgrade pip
RUN pip3 install -U selenium
RUN mkdir /app
RUN mkdir /app/node_modules
WORKDIR /app
COPY Gemfile /app/Gemfile
ENV BUNDLER_VERSION=2.1.4
RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle update --bundler
COPY . /app
RUN yarn
