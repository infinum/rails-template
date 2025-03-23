# frozen_string_literal: true

class TemplateOptions
  module FlipperStorageAdapters
    ALL = [
      ACTIVE_RECORD = 'ActiveRecord',
      REDIS = 'Redis'
    ].freeze
  end

  # @return [String]
  attr_accessor :node_version

  # @return [String]
  attr_reader :flipper_storage_adapter

  # @return [String]
  attr_accessor :code_owners

  # @param [String] adapter
  # @raise [ArgumentError]
  def flipper_storage_adapter=(adapter)
    adapter = FlipperStorageAdapters::ACTIVE_RECORD if adapter == ''
    unless FlipperStorageAdapters::ALL.include?(adapter)
      raise ArgumentError,
            "Unrecognized flipper storage adapter: #{adapter}"
    end

    @flipper_storage_adapter = adapter
  end

  # @return [Boolean]
  def uses_node? = !node_version.empty?
end

# @return [TemplateOptions]
def template_options = @template_options ||= TemplateOptions.new
