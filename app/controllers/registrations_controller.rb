class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @location = initialize_location
    #TODO: Improve error handling
    if @location.nil?
      flash[:error] = 'Could not save user. Invalid address.'
      redirect_to new_user_registration_path
    else
      super
      UserLocation.create!(user: current_user, location: @location, start_date: DateTime.now) if resource.save
    end
  end

  def update
    if current_user.valid_password?(params[:user][:current_password])
      super
      @location = initialize_location
      if location.nil?
        flash.now[:alert] = 'Invalid address location.'
      else
        end_current_user_location
        UserLocation.create!(user: current_user, location: @location, start_date: DateTime.now)
      end
    else
      flash[:alert] = 'Current password is required to save the changes.'
      redirect_to edit_user_registration_path
    end
  end

  def edit
    @location = current_user.user_locations.find_by(end_date: nil).location
    super
  end

  private

  def end_current_user_location
    user_location = current_user.user_locations.find_by(end_date: nil)
    user_location.end_date = DateTime.now
    user_location.save
  end

  def initialize_location
    Location.initialize_from_string(params[:location][:name])
  end

  protected

  def after_update_path_for(resource)
    #TODO: This only works for success case.
    edit_user_registration_path(resource)
  end

end