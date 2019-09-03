# frozen_string_literal: true

# User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :user_locations
  has_many :locations, through: :user_locations
  accepts_nested_attributes_for :user_locations


  # Used to fill registration form when registration via facebook failed
  # Gets email address from session and fills email field in user instance
  def self.new_with_session(params, session)
    super.tap do |user|
      data = session.dig(:'devise.facebook_data', :extra, :raw_info)
      user.email = data['email'] if data && user.email.blank?
    end
  end

  # Finds existing user or creates new by provider and uid fields
  # Assigns email, password, name and image if new user is creating
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
