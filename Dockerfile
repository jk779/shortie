FROM ruby:3.2.2-alpine

# Install necessary libraries
RUN apk add --update --no-cache build-base tzdata

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --binstubs --verbose

# Copy in the application code from your host to your docker image.
COPY . .

# Provide dummy data to Rails so it can pre-compile assets.
# RUN RAILS_ENV=production  \
    # bundle exec rails assets:precompile

# The default command that gets ran will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb
