# frozen_string_literal: true

require_template('util')

template_options.uses_node_runtime = yes?('Will this application need Node runtime? [No]', :green)

template 'README.md.tt', force: true
copy_file 'docs/README.md'
copy_file 'docs/architecture.md'
copy_file 'docs/development_workflow.md'

create_file 'config/environments/staging.rb', "require_relative 'production'"
template 'config/database.yml.tt', force: true

template 'bin/setup', force: true
