# frozen_string_literal: true

# :nocov:
# Application controller
class ApplicationController < ActionController::Base
  # Our ERB partials are living in frontend folder
  prepend_view_path Rails.root.join('frontend')
end
# :nocov:
