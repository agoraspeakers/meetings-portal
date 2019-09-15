# frozen_string_literal: true

module Users
  # Grant and revoke role for user
  class RolesController < ApplicationController
    before_action :set_user
    rescue_from UsersRoles::RoleException do |exception|
      flash[:alert] = exception.message
      redirect_to user_path(@user)
    end

    # POST /users/:user_id/roles
    # Grants given role
    def create
      UsersRoles::Granter.new(@user, role_params).call
      redirect_to @user, notice: t('.grant.success', role: role_params)
    end

    # DELETE users/:user_id/roles
    # Revokes given role
    def destroy
      UsersRoles::Revoker.new(@user, role_params).call
      redirect_to @user, notice: t('.revoke.success', role: role_params)
    end

    private

    # Sets user by given user_id
    def set_user
      @user = User.find(params[:user_id])
      authorize [:users, :roles, @user]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role_name)
    end
  end
end
