# frozen_string_literal: true

module Users
  # Grant and revoke admin role for user
  class AdminController < ApplicationController
    before_action :set_user

    # POST /users/:id/admin
    # Grants admin role
    def create
      if @user.update(role: :admin)
        redirect_to @user, notice: t('.success')
      else
        flash[:alert] = t('.failure')
        redirect_to user_path(@user)
      end
    end

    # DELETE /users/:id/admin
    # Revokes admin role
    def destroy
      if User.admin.count == 1
        flash[:alert] = t('.cant_remove_last_admin')
        redirect_to user_path(@user)
      elsif @user.update(role: nil)
        redirect_to @user, notice: t('.success')
      else
        flash[:alert] = t('.failure')
        redirect_to user_path(@user)
      end
    end

    private

    # Sets user by given user_id
    def set_user
      @user = User.find(params[:user_id])
      authorize [:users, :roles_admin, @user]
    end
  end
end