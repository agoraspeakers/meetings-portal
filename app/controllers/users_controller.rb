# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show set_admin]

  # Gets all users
  def index
    @users = User.all
  end

  # GET /users/1
  def show; end

  # PATCH /users/1
  # Updates user's role
  def set_admin
    role = ActiveModel::Type::Boolean.new.cast(role_params[:admin]) ? :admin : nil
    respond_to do |format|
      if @user.update(role: role)
        format.html { redirect_to @user, notice: t('.role_updated') }
      else
        flash[:alert] = t('.role_not_updated')
        format.html { render :show }
      end
    end
  end

  private

  # Sets user by given id
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:admin)
  end
end
