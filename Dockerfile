FROM ruby:2.7-alpine

LABEL maintainer="Ettore Berardi <ettore.berardi@outlook.com>"

ENV ORGANISED_EXCHANGE_ORIGIN="/calendar.ics"

COPY . .
RUN bundle config set without 'test development' && \
    bundle install

ENTRYPOINT ["ruby", "./bin/exchange_to_org.rb"]
