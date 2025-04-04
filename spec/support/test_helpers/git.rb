# frozen_string_literal: true

module TestHelpers
  module Git
    # @return [Git]
    def git_open
      ::Git.open(File.expand_path('demo', aruba.config.home_directory))
    end
  end
end
