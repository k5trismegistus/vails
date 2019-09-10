FROM ruby:2.6-slim-stretch

# install necessary packages
RUN apt-get update && apt-get install -y build-essential nodejs libpq-dev imagemagick ruby-dev zlib1g-dev liblzma-dev ffmpeg

RUN gem install bundler
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
RUN mkdir -p /app
WORKDIR /app
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "'0.0.0.0'"]
