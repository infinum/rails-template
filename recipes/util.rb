# frozen_string_literal: true

class TemplateOptions
  module FlipperStorageAdapters
    ALL = [
      ACTIVE_RECORD = 'ActiveRecord',
      REDIS = 'Redis'
    ].freeze
  end
  COMMIT_MSG = 'Generated using infinum/rails-template'

  # @return [String]
  attr_accessor :node_version

  # @return [String]
  attr_reader :flipper_storage_adapter

  # @return [String]
  attr_accessor :code_owners

  # @return [Boolean]
  attr_reader :uses_docker

  # @return [String]
  attr_reader :commit_msg

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

  # @param [String] msg
  def commit_msg=(msg)
    @commit_msg = msg.empty? ? COMMIT_MSG : msg
  end
end

# @return [TemplateOptions]
def template_options = @template_options ||= TemplateOptions.new

# @return [Boolean]
def uses_bootsnap? = !options[:skip_bootsnap] && !options[:dev]

# @return [Boolean]
def uses_pg? = options[:database] == 'postgresql'
