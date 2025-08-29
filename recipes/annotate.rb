# frozen_string_literal: true

rails_command 'generate annotate_rb:install'
gsub_file! '.annotaterb.yml', ':exclude_tests: false', ':exclude_tests: true'
