# frozen_string_literal: true

template 'config/initializers/sidekiq.rb.tt'
copy_file 'spec/support/sidekiq.rb'
copy_file 'config/sidekiq.yml'
append_to_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
  <<-HEREDOC

  mount Sidekiq::Web, at: "/sidekiq"
  HEREDOC
end

if api_mode?
  append_to_file 'config/application.rb', after: "config.api_only = true\n" do
    <<-HEREDOC

    # https://github.com/sidekiq/sidekiq/wiki/Monitoring#rack-session-and-protection-against-web-attacks
    config.session_store :cookie_store, key: "_#{app_name}_session"
    HEREDOC
  end
end
