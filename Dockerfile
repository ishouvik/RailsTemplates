FROM ishouvik/rails-nginx-unicorn:latest
MAINTAINER Shouvik Mukherjee <contact@ishouvik.com>

# Set workdir
WORKDIR /app
COPY . /app

#(required) Install Rails App
RUN bundle install --without development test
