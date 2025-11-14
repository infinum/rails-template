# frozen_string_literal: true

template 'config/database.yml.tt', force: true if uses_pg?
create_file 'config/environments/staging.rb', "require_relative 'production'"
copy_file 'config/initializers/bugsnag.rb'
append_to_file 'config/puma.rb', after: /pidfile ENV.*\n/ do
  <<~RUBY

    # Suppress SignalException when SIGTERM is received
    #
    raise_exception_on_sigterm false
  RUBY
end
environment <<~HEREDOC, env: :development
  config.after_initialize do
    Bullet.enable = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end
HEREDOC

insert_into_file 'config/application.rb', before: /  end\nend\Z/ do
  <<~RUBY.indent(4)

    # Report app revision via X-App-Revision header
    config.middleware.use InfinumAppRevision::Middleware, version_provider: InfinumAppRevision::VersionProvider::Docker.new
  RUBY
end
