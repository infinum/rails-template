# frozen_string_literal: true

Flipper::UI.configure do |config|
    config.descriptions_source = -> (keys) do
      {
        # when creating a new feature flag, insert its name and description here e.g.
        # 'new_feature' => 'This is a new feature'
      }
    end
    config.show_feature_description_in_list = true
  end

  Flipper::AuthenticatedApp = Flipper::UI.app(Flipper.instance) do |builder|
    builder.use Rack::Auth::Basic, "Flipper Admin" do |username, password|
      flipper_username = ENV.fetch('FLIPPER_USERNAME')
      flipper_password = ENV.fetch('FLIPPER_PASSWORD')

      next false if flipper_username.blank? || flipper_password.blank?

      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                  Digest::SHA256.hexdigest(flipper_username)) &&
        ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                    Digest::SHA256.hexdigest(flipper_password))
    end
  end
