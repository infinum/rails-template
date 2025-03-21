require "fileutils"
require "shellwords"

def main
  with_option(:uses_node_runtime, yes?('Will this application need Node runtime? [No]', :green))
  add_template_repository_to_source_path
  template "README.md.tt", force: true
end

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    tempdir = Dir.mktmpdir("rails-template-")
    source_paths.unshift(tempdir)

    at_exit { FileUtils.remove_entry(tempdir) }

    git clone: [
      "--quiet",
      "--depth=1",
      "https://github.com/vr4b4c/rails-template.git",
      tempdir
    ].map(&:shellescape).join(" ")

    branch = __FILE__[%r{rails-template/(.+)/template.rb}, 1]

    Dir.chdir(tempdir) { git checkout: branch } if branch
  else
    source_paths.unshift(__dir__)
  end
end

def with_option(key, value)
  @options = options.merge(key => value)
end

main
