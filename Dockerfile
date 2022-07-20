FROM ruby:2.7.2-alpine
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs chromium chromium-chromedriver python3 python3-dev py3-pip yarn git procps
RUN apk --update add less
RUN pip install --upgrade pip
RUN pip3 install -U selenium
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV BUNDLER_VERSION=2.1.4
RUN bundle update --bundler
RUN bundle install
COPY package.json yarn.lock ./
RUN yarn
COPY . /app
