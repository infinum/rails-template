ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim AS base

ARG DOCKER=1
ENV DOCKER=$DOCKER
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    git \
    curl \
    unzip \
    libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives /var/lib/apt/lists /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -o /tmp/awscliv2.zip \
  && unzip /tmp/awscliv2.zip -d /tmp \
  && /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update \
  && rm -rf /tmp/aws /tmp/awscliv2.zip

RUN git config --global user.email 'team-rails@infinum.com'
RUN git config --global user.name 'Team Rails'

WORKDIR /rails-template
ARG RAILS_VERSION=8
RUN gem install rails -v "~> ${RAILS_VERSION}"

COPY Gemfile* .
RUN bundle install

FROM base AS ci
COPY . .
