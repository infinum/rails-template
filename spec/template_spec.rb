# frozen_string_literal: true

RSpec.describe 'Template', type: :aruba do
  before do
    unset_bundler_env_vars
  end

  it 'works with default options' do
    run_command 'rails new demo --api --minimal -d postgresql -B -m --template ../../template.rb'
    type ''
    type ''
    type ''

    expect(last_command_started).to have_output(include_output_string, 'All commit-msg hooks passed')
  end

  it 'works with default options' do
    run_command 'rails new demo --api --minimal -d postgresql -B -m --template ../../template.rb'
    type ''
    type ''
    type 'Initial commit'

    expect(last_command_started).to have_output(include_output_string, 'All commit-msg hooks passed')
  end
end
