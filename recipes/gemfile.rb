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

def development_group_gems
  <<~HEREDOC
    gem 'annotate'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'bullet'
    gem 'overcommit', require: false
    gem 'thor', require: false
  HEREDOC
end

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

if File.foreach('Gemfile').grep(/group :test do/).any?
  append_to_file 'Gemfile', after: /group :test do\n/ do
    <<~HEREDOC
      gem 'rspec-rails'
    HEREDOC
  end
else
  append_to_file 'Gemfile' do
    <<~HEREDOC

      group :test do
        gem 'rspec-rails'
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
