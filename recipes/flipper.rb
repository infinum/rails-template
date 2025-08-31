# frozen_string_literal: true

self.flipper_storage_adapter = ask(
  'Specify storage adapter for Flipper (ActiveRecord, Redis). [Default: ActiveRecord]', :green
)
append_to_file 'Gemfile' do
  if flipper_storage_adapter == FlipperStorageAdapters::ACTIVE_RECORD
    <<~HEREDOC.strip_heredoc

      gem 'flipper-active_record'
      gem 'flipper-ui'
    HEREDOC
  else
    <<~HEREDOC.strip_heredoc

      gem 'flipper-redis'
      gem 'flipper-ui'
    HEREDOC
  end
end

append_to_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
  <<-HEREDOC

  mount Flipper::AuthenticatedApp, at: '/flipper'
  HEREDOC
end

after_bundle do
  rails_command 'generate flipper:setup' if flipper_storage_adapter == FlipperStorageAdapters::ACTIVE_RECORD
end
