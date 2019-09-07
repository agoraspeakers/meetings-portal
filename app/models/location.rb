class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  validate :validate_location

  # geocoded_by :location       # can also be an IP address
  # after_validation :geocode  # auto-fetch coordinates


  def validate_location
    errors.add(:name, "Location can't be found. Please provide more specific location") if :name.nil?
  end

  def self.initialize_from_string(location_str)
    if location_str.is_a?(String) && location_str.present?
      # in case of 'Szczecin' geocoder will return 7 results. How do we handle that ?
      geocoder_location = Geocoder.search(location_str)
      unless geocoder_location.empty?
        latitude = geocoder_location.first.coordinates[0]
        longitude = geocoder_location.first.coordinates[1]
        location_name = geocoder_location.first.display_name
        Location.find_or_initialize_by(name: location_name, latitude: latitude, longitude: longitude)
      end
    end
  end
end
