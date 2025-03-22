# frozen_string_literal: true

Rails.application.configure do
  # for some reason webhook requests are being called twice without this, more on this link: https://github.com/flippercloud/flipper/pull/523
  config.flipper.memoize = false

  # if we are using webhooks, this will make sure our flags are synchronized upon initialization
  config.after_initialize { Flipper.sync }
end
