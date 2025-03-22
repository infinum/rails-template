# frozen_string_literal: true

require 'securerandom'

require_template('util')

template_options.uses_node_runtime = yes?('Will this application need Node runtime? [No]', :green)

template 'README.md.tt', force: true
copy_file 'docs/README.md'
copy_file 'docs/architecture.md'
copy_file 'docs/development_workflow.md'

create_file 'config/environments/staging.rb', "require_relative 'production'"
template 'config/database.yml.tt', force: true

template 'sample.env.tt'
template 'bin/setup.tt', force: true
chmod 'bin/setup', 0o755, verbose: false
template 'bin/update.tt'
chmod 'bin/update', 0o755, verbose: false
copy_file 'bin/ci-checks'
chmod 'bin/ci-checks', 0o755, verbose: false

copy_file 'infra/ci/bundle.config'
copy_file 'config/initializers/bugsnag.rb'

# Remove unused gems
%w[jbuilder tzinfo-data byebug web-console importmap-rails brakeman rubocop-rails-omakase turbo-rails
   stimulus-rails].each { gsub_file('Gemfile', /gem "#{_1}".*\n/, '') }

# Remove comments from the Gemfile
gsub_file('Gemfile', /^\s*#+.*\n/, '')

append_to_file 'Gemfile', after: /gem "rails".*\n/ do
  <<-HEREDOC.strip_heredoc

    gem 'bugsnag'
    gem 'pry-byebug'
    gem 'pry-rails'
    gem 'strong_migrations'
  HEREDOC
end

append_to_file 'Gemfile', after: "group :development do\n" do
  <<-HEREDOC
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'overcommit', require: false
  HEREDOC
end

append_to_file 'Gemfile' do
  <<-HEREDOC.strip_heredoc

    group :test do
      gem 'rspec-rails'
    end
  HEREDOC
end

append_to_file 'Gemfile' do
  <<-HEREDOC.strip_heredoc

    group :ci do
      gem 'brakeman', require: false
      gem 'bundler-audit', require: false
      gem 'rubocop-infinum', require: false
    end
  HEREDOC
end

environment <<~HEREDOC, env: :development
  config.action_mailer.delivery_method = :letter_opener

  config.after_initialize do
    Bullet.enable = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
  end
HEREDOC

require_template('flipper')

# Suppress Puma SignalException
append_to_file 'config/puma.rb', after: /pidfile ENV.*\n/ do
  <<~RUBY

    # Suppress SignalException when SIGTERM is received
    #
    raise_exception_on_sigterm false
  RUBY
end

# Stop crawlers
append_to_file 'public/robots.txt' do
  <<-HEREDOC.strip_heredoc
  # no bot may crawl
  User-agent: *
  Disallow: /
  HEREDOC
end

copy_file '.rubocop.yml'
copy_file '.overcommit.yml'

append_to_file '.gitignore' do
  <<-HEREDOC.strip_heredoc
  .sass-cache
  powder
  public/system
  dump.rdb
  logfile
  .DS_Store
  HEREDOC
end

copy_file '.github/PULL_REQUEST_TEMPLATE.md'
