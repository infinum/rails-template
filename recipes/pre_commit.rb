# frozen_string_literal: true

if in_docker?
  run 'rails db:migrate'
else
  run "docker compose run --rm runner bash -c 'bundle exec rails db:migrate'"
end
rails_command 'generate strong_migrations:install'
run 'bundle exec rubocop --autocorrect-all --fail-level=error --format=quiet'
