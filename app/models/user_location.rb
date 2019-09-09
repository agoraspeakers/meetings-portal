# frozen_string_literal: true

# UserLocation
class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates_presence_of :user
  validates_presence_of :location

end
