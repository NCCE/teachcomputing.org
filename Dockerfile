FROM ruby:3.1.2-alpine
RUN apk update
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs yarn procps bash bash-completion sudo openssh docker git less shared-mime-info graphviz
RUN curl https://cli-assets.heroku.com/install.sh | sh
WORKDIR /app
RUN bundle config set force_ruby_platform true
COPY Gemfile Gemfile.lock /app/
RUN bundle install
COPY scripts/templates/* /root/
