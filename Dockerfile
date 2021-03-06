FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /Note

WORKDIR /Note

COPY Gemfile /Note/Gemfile
COPY Gemfile.lock /Note/Gemfile.lock

RUN bundle install

COPY . /Note