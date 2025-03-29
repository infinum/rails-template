# frozen_string_literal: true

# template_options.flipper_storage_adapter = ask(
#   'Specify storage adapter for Flipper (ActiveRecord, Redis). [Default: ActiveRecord]', :green
# )

# append_to_file 'Gemfile', after: /gem "rails".*\n/ do
#   if template_options.flipper_storage_adapter == TemplateOptions::FlipperStorageAdapters::ACTIVE_RECORD
#     <<~HEREDOC

#       gem 'flipper-active_record'
#       gem 'flipper-ui'
#     HEREDOC
#   else
#     <<~HEREDOC

#       gem 'flipper-redis'
#       gem 'flipper-ui'
#     HEREDOC
#   end
# end

# copy_file 'config/initializers/flipper.rb'

# append_to_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
#   "mount Flipper::AuthenticatedApp, at: '/flipper'"
# end
