# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('policy.not_authorized')
    redirect_to(root_path)
  end
end
