# frozen_string_literal: true

template_options.commit_msg = ask(
  "Specify initial commit message. [Default: #{TemplateOptions::COMMIT_MSG}]",
  :green
)
run "git add .; git commit -m '#{template_options.commit_msg}'" unless template_options.commit_msg.empty?
