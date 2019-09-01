# frozen_string_literal: true

# User
class User < ApplicationRecord
  enum role: [:admin]
  before_create :set_first_record_as_admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

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

  private

  # Currently have to be unscoped because #ActiveRecord::Relation::create method adds scope to query
  # in Rails 6.1 class level methods will no longer inherit scoping
  # in Rails 6.0 it is already deprecated: https://github.com/rails/rails/pull/35280
  # After upgrade to Rails 6.1, please remove the `unscoped` method from code below and fix specs
  def set_first_record_as_admin
    self.role = :admin unless User.unscoped.any?
  end
end
