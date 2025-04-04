ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim AS base

ARG DOCKER=1
ENV DOCKER=$DOCKER
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives /var/lib/apt/lists /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /rails-template
COPY Gemfile* .
RUN bundle install

FROM base AS ci
ARG RAILS_VERSION=8
RUN gem install rails -v "~> ${RAILS_VERSION}"
COPY . .
