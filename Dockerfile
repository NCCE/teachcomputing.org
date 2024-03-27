FROM ruby:3.1.2-alpine
RUN apk update
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs chromium chromium-chromedriver python3 python3-dev py3-pip yarn procps bash bash-completion sudo openssh docker git less graphviz
RUN pip install --upgrade pip
RUN pip3 install -U selenium
RUN curl https://cli-assets.heroku.com/install.sh | sh
WORKDIR /app
RUN bundle config set force_ruby_platform true
COPY Gemfile Gemfile.lock /app/
COPY scripts/templates/* /root/
