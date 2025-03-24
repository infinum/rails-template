# frozen_string_literal: true

TEMPLATES_DIR = 'templates'
REMOTE_REPO_LOCAL_PREFIX = 'rails-template-'

def main
  setup

  apply_recipe('main')
end

# @return [void]
def setup
  @template_root_dir = __FILE__.match?(%r{\Ahttps://}) ? setup_remote_repo : setup_local_repo

  source_paths.unshift(File.expand_path(TEMPLATES_DIR, template_root_dir))
end

# @return [String]
def setup_remote_repo
  require 'tmpdir'
  require 'fileutils'

  dir = Dir.mktmpdir(REMOTE_REPO_LOCAL_PREFIX)
  at_exit { FileUtils.remove_entry(dir) }
  clone_git_repo(dir)
  dir
end

# @param [String] destination
# @return [void]
def clone_git_repo(destination)
  require 'shellwords'

  git clone: [
    '--quiet',
    '--depth=1',
    'https://github.com/infinum/rails-template.git',
    destination
  ].map(&:shellescape).join(' ')
end

# @return [String]
def setup_local_repo = __dir__

self.class.class_eval do
  # @return [String]
  attr_reader :template_root_dir
end

# @param [String] path
# @return [void]
def apply_recipe(path) = apply(recipe_file(path))

# @param [String] path
# @return [String]
def recipe_file(path) = File.expand_path("recipes/#{path}.rb", template_root_dir)

main
