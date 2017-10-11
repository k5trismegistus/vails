FROM ruby:2.4-alpine3.6

# install necessary packages
RUN apk update && apk add alpine-sdk nodejs sqlite-dev ffmpeg imagemagick ruby-dev zlib-dev xz-dev

RUN gem install bundler
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
RUN mkdir -p /app
WORKDIR /app
