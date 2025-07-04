# frozen_string_literal: true

run 'bundle lock --add-platform ruby'
run 'bundle install'
if in_docker?
  run 'bin/setup'
else
  run 'docker compose run --build --rm --entrypoint /bin/bash runner -c bin/setup'
end
rails_command 'generate rspec:install'
rails_command 'generate annotate:install'
append_to_file 'lib/tasks/auto_annotate_models.rake', after: "its thing in production.\n" do
  "# rubocop:disable Metrics/BlockLength, Rails/RakeEnvironment\n"
end
append_to_file 'lib/tasks/auto_annotate_models.rake', '# rubocop:enable Metrics/BlockLength, Rails/RakeEnvironment'
rails_command 'generate strong_migrations:install'
run 'bundle exec rubocop -A --fail-level=error --format=quiet'

# add a list of permitted licenses to license_finder configuration fileAdd commentMore actions
run 'bundle exec license_finder permitted_licenses add "New BSD" "Simplified BSD" ruby "2-clause BSDL" ' \
    '"Python-2.0" MIT "Apache 2.0" ISC CC0-1.0 CC-BY-3.0 "Mozilla Public License 2.0" LGPL MIT-0 ' \
    '"Brakeman Public Use License" Apache "(CC-BY-4.0 AND OFL-1.1 AND MIT)" CC-BY-4.0 ' \
    '"MPL-2.0 OR Apache-2.0" "(MIT AND Zlib)" "(WTFPL OR MIT)" "PayPal SDK License" ' \
    '"MIT (http://mootools.net/license.txt)" "(MIT AND CC-BY-3.0)" 0BSD BSD '

# add a list of restricted licenses to license_finder configuration file
run 'bundle exec license_finder restrict add GPL-2.0 GPL-3.0'

# add bundle-audit gem to approved gems list
run 'bundle exec license_finder approvals add bundler-audit'
