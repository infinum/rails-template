# frozen_string_literal: true

append_to_file 'Gemfile', after: /gem 'rubocop-infinum'.*\n/ do
  <<-HEREDOC
  gem 'license_finder', require: false
  HEREDOC
end

append_to_file '.overcommit.yml', after: /command: \['bundle', 'exec', 'rubocop'\].*\n/ do
  <<-HEREDOC

  LicenseFinder:
    enabled: true
    on_warn: fail
    command: ['bundle', 'exec', 'license_finder']
    requires_files: true
    include:
      - 'Gemfile*'
      - 'package.json'
  HEREDOC
end
