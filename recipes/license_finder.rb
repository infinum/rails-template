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

after_bundle do
  bundle_command 'exec license_finder permitted_licenses add "New BSD" "Simplified BSD" ruby "2-clause BSDL" ' \
                 '"Python-2.0" MIT "Apache 2.0" ISC CC0-1.0 CC-BY-3.0 "Mozilla Public License 2.0" LGPL MIT-0 ' \
                 '"Brakeman Public Use License" Apache "(CC-BY-4.0 AND OFL-1.1 AND MIT)" CC-BY-4.0 ' \
                 '"MPL-2.0 OR Apache-2.0" "(MIT AND Zlib)" "(WTFPL OR MIT)" "PayPal SDK License" ' \
                 '"MIT (http://mootools.net/license.txt)" "(MIT AND CC-BY-3.0)" 0BSD BSD '

  bundle_command 'exec license_finder restrict add GPL-2.0 GPL-3.0'

  bundle_command 'exec license_finder approvals add bundler-audit'
end
