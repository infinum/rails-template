# frozen_string_literal: true

Flipper::UI.configure do |config|
  config.descriptions_source = lambda { |_keys|
    {
      # when creating a new feature flag, insert its name and description here e.g.
      # 'new_feature' => 'This is a new feature'
    }
  }
  config.show_feature_description_in_list = true
end
# If you want to Audit your Flipper enable/disable actions, uncomment the following code and create FlipperAuditLog table
# with the provided values
# class FlipperSubscriber
#   def call(*args)
#     event = ActiveSupport::Notifications::Event.new(*args)
#     if event.payload[:operation].in?(%i[enable disable])
#       FlipperAuditLog.create!(
#         operation: event.payload[:operation],
#         feature_name: event.payload[:feature].name,
#         thing_value: event.payload[:thing_value],
#         gate_name: event.payload[:gate_name],
#         result: event.payload[:result]
#       )
#     end
#   end
#
# end

#  ActiveSupport::Notifications.subscribe(/flipper/, FlipperSubscriber.new)

Flipper::AuthenticatedApp = Flipper::UI.app(Flipper.instance) do |builder|
  builder.use Rack::Auth::Basic, 'Flipper Admin' do |username, password|
    flipper_username = ENV.fetch(:flipper_username)
    flipper_password = ENV.fetch(:flipper_password)
    next false if flipper_username.blank? || flipper_password.blank?

    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                Digest::SHA256.hexdigest(flipper_username)) &&
      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                  Digest::SHA256.hexdigest(flipper_password))
  end
end
