# frozen_string_literal: true

template 'sample.env.tt'
template 'bin/setup.tt', force: true
chmod 'bin/setup', 0o755, verbose: false
copy_file 'bin/ci-checks'
chmod 'bin/ci-checks', 0o755, verbose: false
template 'bin/remote.tt'
chmod 'bin/remote', 0o755, verbose: false
