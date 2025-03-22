# frozen_string_literal: true

class TemplateOptions
  attr_accessor :uses_node_runtime
end

# @return [TemplateOptions]
def template_options = @template_options ||= TemplateOptions.new
