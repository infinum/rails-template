# frozen_string_literal: true

template 'README.md.tt', force: true
copy_file 'SETUP.md'
directory 'docs'
append_to_file 'public/robots.txt' do
  <<~HEREDOC
    # no bot may crawl
    User-agent: *
    Disallow: /
  HEREDOC
end
