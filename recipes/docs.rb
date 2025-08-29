# frozen_string_literal: true

template 'README.md.tt', force: true
copy_file 'SETUP.md'
directory 'docs'
