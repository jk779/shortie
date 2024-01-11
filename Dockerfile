FROM ruby:3.3-alpine

ENV INSTALL_PATH /app
WORKDIR $INSTALL_PATH


RUN apk add --update --no-cache build-base tzdata \
  && mkdir -p $INSTALL_PATH


COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --jobs 8 && bundle binstubs --all

COPY . .

CMD bundle exec puma -C config/puma.rb
