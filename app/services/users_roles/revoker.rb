# frozen_string_literal: true

# Users roles module
module UsersRoles
  # Revokes roles
  class Revoker
    def initialize(user, role)
      raise RoleException, I18n.t('.users.roles.illegal', role: role) unless permitted_role?(role)
      raise RoleException, I18n.t('users.roles.not_assigned', role: role) unless assigned_role?(user, role)

      @user = user
      @role = role
    end

    def call
      raise RoleException, I18n.t('users.roles.revoke.cant_remove_last_admin') if revoke_admin? && last_admin?
      raise RoleException, I18n.t('users.roles.revoke.failure', role: @role) unless update
    end

    private

    def update
      @user.update(role: new_role)
    end

    def new_role
      raise RoleException, I18n.t('.users.roles.revoke.cant_revoke_banned_role') if banned?
      return User.roles[:banned] if @user.user?

      User.roles[:user]
    end

    def revoke_admin?
      @role.eql?(User.roles[:admin])
    end

    def last_admin?
      User.admin.count == 1
    end

    def banned?
      @user.banned?
    end

    def assigned_role?(user, role)
      user.role.eql?(role)
    end

    def permitted_role?(role)
      User.roles.include?(role)
    end
  end
end
