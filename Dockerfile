ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim AS base

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives /var/lib/apt/lists /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /rails-template
COPY Gemfile* .
RUN bundle install

FROM base AS ci
COPY . .
