# frozen_string_literal: true

require 'securerandom'

apply_recipe('util')

apply_recipe('containers')
apply_recipe('bin')
apply_recipe('gemfile')
apply_recipe('setup_dev') # Before this recipe, apply changes necessary to setup development environment

apply_recipe('annotate')
apply_recipe('config')
apply_recipe('docs')
apply_recipe('dotfiles')
apply_recipe('flipper')
apply_recipe('github')
apply_recipe('license_finder')
apply_recipe('rspec')
apply_recipe('web')

apply_recipe('pre_commit')
apply_recipe('commit') # It's not expected to modify Rails application after this recipe

puts "\n\n"
puts '*********************************************************'
puts '* IMPORTANT: Follow post-apply instructions in SETUP.md *'
puts '*********************************************************'
puts "\n\n"
