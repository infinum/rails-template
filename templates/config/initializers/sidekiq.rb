# frozen_string_literal: true

require 'sidekiq/web'

# https://github.com/sidekiq/sidekiq/wiki/Monitoring#rails-http-basic-auth-from-routes
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  sidekiq_username = ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USERNAME'))
  sidekiq_password = ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD'))

  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), sidekiq_username) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), sidekiq_password)
end
