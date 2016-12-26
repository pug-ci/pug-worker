FROM ruby:2.3.3

MAINTAINER Pug CI Team

WORKDIR /apps/pug-worker

ADD Gemfile* /apps/pug-worker/

RUN gem install bundler
RUN bundle install --without development test

ADD . /apps/pug-worker

CMD bundle exec foreman start -f Procfile
