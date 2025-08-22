# frozen_string_literal: true

directory 'infra'
template 'Dockerfile.tt', force: true
template 'compose.yml.tt', force: true
