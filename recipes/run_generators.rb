# frozen_string_literal: true

run 'bundle lock --add-platform ruby'
run 'bundle install'
run 'docker compose run --build --rm --entrypoint /bin/bash runner -c bin/setup'
rails_command 'generate rspec:install'
rails_command 'generate annotate:install'
append_to_file 'lib/tasks/auto_annotate_models.rake', after: "its thing in production.\n" do
  "# rubocop:disable Metrics/BlockLength, Rails/RakeEnvironment\n"
end
append_to_file 'lib/tasks/auto_annotate_models.rake', '# rubocop:enable Metrics/BlockLength, Rails/RakeEnvironment'
rails_command 'generate strong_migrations:install'
run 'bundle exec rubocop -A'
