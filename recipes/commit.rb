# frozen_string_literal: true

self.commit_msg = ask(
  "Specify initial commit message. [Default: #{COMMIT_MSG}]",
  :green
)
run "git add .; git commit -m '#{commit_msg}'" unless commit_msg.empty?
