FROM ruby:2.6.5-alpine

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache \
  build-base curl-dev git postgresql-dev \
  yaml-dev zlib-dev nodejs yarn tzdata

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler:2.0.2

RUN bundle install

COPY . /app

# Clean APK cache
RUN rm -rf /var/cache/apk/*
