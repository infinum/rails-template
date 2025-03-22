# frozen_string_literal: true

require 'securerandom'

require_template('util')

template_options.uses_node_runtime = yes?('Will this application need Node runtime? [No]', :green)

template 'README.md.tt', force: true
copy_file 'docs/README.md'
copy_file 'docs/architecture.md'
copy_file 'docs/development_workflow.md'

create_file 'config/environments/staging.rb', "require_relative 'production'"
template 'config/database.yml.tt', force: true

template 'sample.env.tt'
template 'bin/setup.tt', force: true
chmod 'bin/setup', 0o755, verbose: false
template 'bin/update.tt'
chmod 'bin/update', 0o755, verbose: false
copy_file 'bin/ci-checks'
chmod 'bin/ci-checks', 0o755, verbose: false

copy_file '.bundle/ci/config'
copy_file 'config/initializers/bugsnag.rb'
