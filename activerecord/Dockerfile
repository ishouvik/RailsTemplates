FROM ruby:2.3.4-alpine
MAINTAINER Shouvik Mukherjee <contact@ishouvik.com>

# Setup system packages
RUN \
  apk update && \
  apk upgrade && \
  apk add --no-cache \
  build-base \
  bash \
  git \
  less \
  tzdata \
  mysql-dev \
  nodejs

# Setup workdir
RUN mkdir /app
WORKDIR /app

# Install foreman gem for managing processes
RUN gem install foreman

# Install gems
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Add all application files to workdir
ADD . /app

# Expose server port
EXPOSE 5000
