# frozen_string_literal: true

# Location
class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  # Used to initialize a new location.
  # Checks if geocoder comes back with a result for a given location
  # If geocoder comes back with a result it takes the first record and pulls it from the database or initializes new one
  def self.initialize_from_string(location_str)
    if location_str.is_a?(String) && location_str.present?
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
