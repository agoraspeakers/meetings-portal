class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    perform_create(params[:location][:name])
  end

  def update
    if resource.save
      provided_location = params[:location][:name]
      user_location = perform_create(provided_location)
      if user_location.nil?
        flash[:alert] = "Invalid address."
        redirect_to :edit_user_registration
      else
        super
        end_current_user_location
      end
    end
  end

  def edit
    @location = current_user.user_locations.find_by(end_date: nil).location
    super
  end

  private

  def perform_create(location_str)
    location = Location.string_location(location_str)
    unless location.nil?
      UserLocation.create!(user: current_user, location: location, start_date: DateTime.now)
    end
  end

  def end_current_user_location
    current_user.user_locations.find_by(end_date: nil).end_date = DateTime.now
    current_user.save
  end
end