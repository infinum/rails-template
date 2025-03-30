# frozen_string_literal: true

self.code_owners = ask(
  'Specify GitHub code owners (eg. @bob @alice). [Default: none]',
  :green
)
template '.github/CODEOWNERS.tt' unless code_owners.empty?
template '.github/dependabot.yml.tt'
copy_file '.github/PULL_REQUEST_TEMPLATE.md'
directory '.github/workflows'
