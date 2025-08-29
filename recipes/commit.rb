# frozen_string_literal: true

self.commit_msg = ask(
  "Specify initial commit message. [Default: #{COMMIT_MSG}]",
  :green
)
run "git add .; OVERCOMMIT_DISABLE=1 git commit -m '#{commit_msg}' --no-verify" unless commit_msg.empty?
