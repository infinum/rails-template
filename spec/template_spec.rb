# frozen_string_literal: true

RSpec.describe 'Template', type: :aruba do
  before do
    unset_bundler_env_vars
  end

  context 'with default options' do
    before do
      apply_template
    end

    it 'completes successfully' do
      expect(last_command_started).to have_output(include_output_string, 'All commit-msg hooks passed')
    end
  end

  context 'with custom commit message' do
    before do
      apply_template(commit_msg: 'Initial commit')
    end

    it 'commits with custom message' do
      expect(last_command_started).to have_output(include_output_string, 'All commit-msg hooks passed')

      sleep(2)
      expect(git_open.log.first.message).to eq('Initial commit')
    end
  end
end
