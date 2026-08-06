# frozen_string_literal: true

module TestHelpers
  module Command
    DEFAULT_CMD = 'rails new demo --api -d postgresql -B -m --template ../../template.rb --force'
    DEFAULT_DEMO_PATH = 'tmp/aruba/demo'

    # @param opts [Hash<Symbol => Object>]
    # @option :cmd [String]
    # @option :scenario [Symbol] Name of the scenario to use (overrides individual options)
    # @option :node_version [String]
    # @option :code_owners [String]
    # @option :flipper_storage_adapter [String]
    # @option :commit_msg [String]
    # @return [void]
    def apply_template(**opts)
      cleanup
      run_command(opts.fetch(:cmd, DEFAULT_CMD))

      # If a scenario is specified, use its configuration
      # Individual options can still override scenario defaults
      if opts.key?(:scenario)
        scenario_config = scenario(opts[:scenario])
        node_version = opts.fetch(:node_version, scenario_config[:node_version])
        code_owners = opts.fetch(:code_owners, scenario_config[:code_owners])
        flipper_storage_adapter = opts.fetch(:flipper_storage_adapter, scenario_config[:flipper_storage_adapter])
        commit_msg = opts.fetch(:commit_msg, scenario_config[:commit_msg])
      else
        node_version = opts.fetch(:node_version, '')
        code_owners = opts.fetch(:code_owners, '')
        flipper_storage_adapter = opts.fetch(:flipper_storage_adapter, '')
        commit_msg = opts.fetch(:commit_msg, '')
      end

      type(node_version)
      type(code_owners)
      type(flipper_storage_adapter)
      type(commit_msg)
    end

    # @return [void]
    def debug_output
      File.write('tmp/debug.log', last_command_started.output)
    end

    # @return [void]
    def cleanup
      return unless File.exist?(File.join(DEFAULT_DEMO_PATH, 'compose.yml'))

      Dir.chdir(DEFAULT_DEMO_PATH) do
        `docker compose down`
        `docker volume rm demo_postgres`
      end
    end
  end
end
