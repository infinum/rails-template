# frozen_string_literal: true

append_to_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
  <<-HEREDOC

  mount Flipper::AuthenticatedApp, at: '/flipper'
  HEREDOC
end
