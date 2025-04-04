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
  HEREDOC
end
append_to_file 'Gemfile' do
  <<~HEREDOC

    group :development do
      gem 'annotate'
      gem 'better_errors'
      gem 'binding_of_caller'
      gem 'bullet'
      gem 'overcommit', require: false
      gem 'thor', require: false
    end
  HEREDOC
end
append_to_file 'Gemfile' do
  <<~HEREDOC

    group :test do
      gem 'rspec-rails'
    end
  HEREDOC
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
