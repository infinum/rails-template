# frozen_string_literal: true

require 'securerandom'

apply_recipe('util')
apply_recipe('dotfiles')
apply_recipe('bin')
apply_recipe('other')
apply_recipe('config')
apply_recipe('gemfile')
apply_recipe('flipper')
apply_recipe('sidekiq')
apply_recipe('github')
apply_recipe('containers')
apply_recipe('license_finder')
apply_recipe('run_generators')
apply_recipe('commit')
