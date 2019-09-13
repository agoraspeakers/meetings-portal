# frozen_string_literal: true

# Users module
module Users
  # Roles module
  module Roles
    # User Policy
    class UserPolicy < ApplicationPolicy
      def create?
        user&.admin?
      end

      def destroy?
        user&.admin?
      end
    end
  end
end
