# frozen_string_literal: true

require_template('util')

template_options.uses_node_runtime = yes?('Will this application need Node runtime? [No]', :green)

template 'README.md.tt', force: true
