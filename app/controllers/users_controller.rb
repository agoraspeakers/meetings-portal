# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[grant_admin revoke_admin]

  # Gets all users
  def index
    @users = authorize User.all
  end

  # GET /users/1
  def show
    @user = authorize User.find(params[:id])
  end

  # POST /users/:id/admin
  # Grants admin role
  def grant_admin
    if @user.update(role: :admin)
      redirect_to @user, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :show
    end
  end

  # DELETE /users/:id/admin
  # Revokes admin role
  def revoke_admin
    if @user.update(role: nil)
      redirect_to @user, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :show
    end
  end

  private

  # Sets user by given user_id
  def set_user
    @user = authorize User.find(params[:user_id])
  end
end
