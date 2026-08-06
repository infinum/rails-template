# frozen_string_literal: true

RSpec.describe 'Template', type: :aruba do
  before { unset_bundler_env_vars }

  after { cleanup }

  context 'with default scenario' do
    before do
      apply_template(scenario: :default)
    end

    it 'completes successfully' do
      expect(last_command_started).to have_output_on_stdout(include_output_string, 'All commit-msg hooks passed')
    end
  end

  context 'with custom commit scenario' do
    before do
      apply_template(scenario: :with_custom_commit)
    end

    it 'commits with custom message', type: :feature do
      expect(last_command_started).to have_output_on_stdout(include_output_string, 'All commit-msg hooks passed')
      expect(git_open.log.first.message).to eq('Initial commit')
    end
  end

  context 'with node version scenario' do
    before do
      apply_template(scenario: :with_node_version)
    end

    it 'completes successfully with node version' do
      expect(last_command_started).to have_output_on_stdout(include_output_string, 'All commit-msg hooks passed')
    end
  end

  context 'with full custom scenario' do
    before do
      apply_template(scenario: :full_custom)
    end

    it 'completes successfully with all custom options', type: :feature do
      expect(last_command_started).to have_output_on_stdout(include_output_string, 'All commit-msg hooks passed')
      expect(git_open.log.first.message).to eq('Custom setup commit')
    end
  end

  context 'with scenario override' do
    before do
      # Use a scenario but override specific options
      apply_template(scenario: :with_custom_commit, commit_msg: 'Overridden commit message')
    end

    it 'uses scenario defaults but allows overrides', type: :feature do
      expect(last_command_started).to have_output_on_stdout(include_output_string, 'All commit-msg hooks passed')
      expect(git_open.log.first.message).to eq('Overridden commit message')
    end
  end
end
