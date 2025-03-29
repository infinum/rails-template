# frozen_string_literal: true

copy_file '.rubocop.yml'
copy_file '.overcommit.yml'
append_to_file '.gitignore' do
  <<~HEREDOC
    .sass-cache
    powder
    public/system
    dump.rdb
    logfile
    .DS_Store
  HEREDOC
end
