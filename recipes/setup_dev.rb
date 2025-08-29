# frozen_string_literal: true

template 'config/database.yml.tt', force: true if uses_pg?
run 'bundle lock --add-platform ruby'
run 'bundle install'
if in_docker?
  run 'bin/setup'
else
  run 'docker compose run --build --rm --entrypoint /bin/bash runner -c bin/setup'
end
