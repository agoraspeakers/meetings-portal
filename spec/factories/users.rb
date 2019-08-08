# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0, 20] }
    provider { 'facebook' }
    uid { Faker::Internet.unique.uuid }
  end
end
