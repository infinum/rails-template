# frozen_string_literal: true

module TestHelpers
  module Command
    DEFAULT_CMD = 'rails new demo --api --minimal -d postgresql -B -m --template ../../template.rb'

    # @param [String] cmd
    # @param [String] node_version
    # @param [String] code_owners
    # @param [String] commit_msg
    # @return [void]
    def apply_template(cmd: DEFAULT_CMD, node_version: '', code_owners: '', commit_msg: '')
      run_command cmd
      type node_version
      type code_owners
      type commit_msg
    end

    # @return [void]
    def debug_output
      File.write('tmp/debug.log', last_command_started.output)
    end
  end
end
