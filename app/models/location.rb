class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  # geocoded_by :location       # can also be an IP address
  # after_validation :geocode  # auto-fetch coordinates

  def self.string_location(location_str)
    if location_str.is_a?(String) && location_str.present?
      # in case of 'Szczecin' geocoder will return 7 results. How do we handle that ?
      geocoder_location = Geocoder.search(location_str)
      unless geocoder_location.empty?
        latitude = geocoder_location.first.coordinates[0]
        longitude = geocoder_location.first.coordinates[1]
        location_name = geocoder_location.first.display_name
        Location.find_or_create_by(name: location_name, latitude: latitude, longitude: longitude)
      end
    end
  end
end
