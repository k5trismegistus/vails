FROM ruby:2.4-alpine3.6

# install necessary packages
RUN apk update && apk add alpine-sdk nodejs postgresql-dev ffmpeg imagemagick ruby-dev zlib-dev xz-dev

RUN gem install bundler
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
RUN mkdir -p /app
WORKDIR /app
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "'0.0.0.0'"]
