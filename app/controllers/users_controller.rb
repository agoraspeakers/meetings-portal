# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  # Gets all users
  def index
    @users = authorize User.all
  end

  # GET /users/1
  def show
    @user = authorize User.find(params[:id])
  end
end
