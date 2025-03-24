# frozen_string_literal: true

template_options.flipper_storage_adapter = ask(
  'Specify storage adapter for Flipper (ActiveRecord, Redis). [Default: ActiveRecord]', :green
)

append_to_file 'Gemfile', after: /gem "rails".*\n/ do
  if template_options.flipper_storage_adapter == TemplateOptions::FlipperStorageAdapters::ACTIVE_RECORD
    <<~HEREDOC.strip_heredoc

      gem 'flipper-active_record'
    HEREDOC
  else
    <<~HEREDOC.strip_heredoc

      gem 'flipper-redis'
    HEREDOC
  end
end

copy_file 'config/flipper.rb'
