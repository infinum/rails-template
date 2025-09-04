# frozen_string_literal: true

%w[jbuilder tzinfo-data byebug web-console importmap-rails brakeman rubocop-rails-omakase turbo-rails
   stimulus-rails].each { gsub_file('Gemfile', /gem "#{it}".*\n/, '') }
gsub_file('Gemfile', /^\s*#+.*\n/, '')
append_to_file 'Gemfile', after: /gem "rails".*\n/ do
  <<~HEREDOC

    gem 'dotenv'
    gem 'bugsnag'
    gem 'pry-byebug'
    gem 'pry-rails'
    gem 'strong_migrations'
    gem 'sidekiq', '~> 8.0'
  HEREDOC
end

development_group_gems =
  <<~HEREDOC
    gem 'annotaterb'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'bullet'
    gem 'overcommit', require: false
    gem 'thor', require: false
  HEREDOC

if File.foreach('Gemfile').grep(/group :development do/).any?
  append_to_file 'Gemfile', after: /group :development do\n/ do
    development_group_gems
  end
else
  append_to_file 'Gemfile' do
    <<~HEREDOC

      group :development do
        #{development_group_gems}
      end
    HEREDOC
  end
end

test_gems =
  <<~HEREDOC
    gem 'rspec-rails'
    gem 'rspec-sidekiq'
  HEREDOC
if File.foreach('Gemfile').grep(/group :test do/).any?
  append_to_file 'Gemfile', test_gems, after: /group :test do\n/
else
  append_to_file 'Gemfile' do
    <<~HEREDOC

      group :test do
        #{test_gems}
      end
    HEREDOC
  end
end

append_to_file 'Gemfile' do
  <<~HEREDOC

    group :ci do
      gem 'brakeman', require: false
      gem 'bundler-audit', require: false
      gem 'rubocop-infinum', require: false
    end
  HEREDOC
end

self.flipper_storage_adapter = ask(
  'Specify storage adapter for Flipper (ActiveRecord, Redis). [Default: ActiveRecord]', :green
)

append_to_file 'Gemfile', after: /gem "rails".*\n/ do
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

append_to_file 'Gemfile', after: /gem 'rubocop-infinum'.*\n/ do
  <<-HEREDOC
  gem 'license_finder', require: false
  HEREDOC
end
