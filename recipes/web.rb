# frozen_string_literal: true

append_to_file 'public/robots.txt' do
  <<~HEREDOC
    # no bot may crawl
    User-agent: *
    Disallow: /
  HEREDOC
end
