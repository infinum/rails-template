# frozen_string_literal: true

after_bundle do
  self.commit_msg = ask(
    "Specify initial commit message. [Default: #{COMMIT_MSG}]",
    :green
  )
  run "git add .; git commit -m '#{commit_msg}' --no-verify" unless commit_msg.empty?
end
