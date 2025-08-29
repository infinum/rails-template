# frozen_string_literal: true

self.node_version = ask(
  "Specify node version. Leave empty if you don't need node. [Default: empty]",
  :green
)

directory 'infra'
template 'Dockerfile.tt', force: true
template 'compose.yml.tt', force: true
