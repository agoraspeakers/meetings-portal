# frozen_string_literal: true

# Users roles module
module UsersRoles
  # Grants roles
  class Granter
    def initialize(user, role)
      raise RoleException, I18n.t('users.roles.illegal', role: role) unless permitted_role?(role)

      @user = user
      @role = role
    end

    def call
      raise RoleException, I18n.t('users.roles.grant.is_banned') if banned?
      raise RoleException, I18n.t('users.roles.grant.failure', role: @role) unless update
    end

    private

    def update
      @user.update(role: @role)
    end

    def banned?
      @user.banned?
    end

    def permitted_role?(role)
      User.roles.include?(role)
    end
  end
end
