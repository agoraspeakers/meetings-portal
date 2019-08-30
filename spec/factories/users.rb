# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0, 20] }
    provider { 'facebook' }
    uid { Faker::Internet.unique.uuid }
    location { "#{Faker::Address.city}, #{Faker::Address.country}" } # country wont match country.
  end
end
