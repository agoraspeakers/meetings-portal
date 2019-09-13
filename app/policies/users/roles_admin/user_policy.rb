# frozen_string_literal: true

# User Policy
module Users
  module RolesAdmin
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
