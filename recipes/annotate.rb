# frozen_string_literal: true

after_bundle do
  rails_command 'generate annotate_rb:install'
  gsub_file! '.annotaterb.yml', ':exclude_tests: false', ':exclude_tests: true'
end
