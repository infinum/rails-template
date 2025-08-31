# frozen_string_literal: true

after_bundle do
  rails_command 'generate rspec:install'
  gsub_file! '.rspec', 'require spec_helper', 'require rails_helper'
  uncomment_lines 'spec/rails_helper.rb', /Rails.root.glob.*/
end
