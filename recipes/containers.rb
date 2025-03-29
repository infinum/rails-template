# frozen_string_literal: true

directory 'infra'
template 'Dockerfile.tt', force: true
template 'docker-compose.yml.tt', force: true
