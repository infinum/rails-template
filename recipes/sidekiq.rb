# frozen_string_literal: true

copy_file 'config/initializers/sidekiq.rb'
copy_file 'spec/support/sidekiq.rb'
copy_file 'config/sidekiq.yml'
append_to_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
  <<-HEREDOC

  mount Sidekiq::Web, at: "/sidekiq"
  HEREDOC
end

if api_mode?
  append_to_file 'config/application.rb', after: 'config.api_only = true' do
    <<-HEREDOC

    # Configure session middleware for Sidekiq in API mode
    config.session_store :cookie_store, key: "_#{app_name}_session"
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    HEREDOC
  end
end
