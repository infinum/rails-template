# frozen_string_literal: true

template_options.node_version = ask(
  "Specify node version. Leave empty if you don't need node. [Default: empty]",
  :green
)

template 'sample.env.tt'
template 'bin/setup.tt', force: true
chmod 'bin/setup', 0o755, verbose: false
copy_file 'bin/ci-checks'
chmod 'bin/ci-checks', 0o755, verbose: false
template 'bin/remote.tt'
chmod 'bin/remote', 0o755, verbose: false
