# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0, 20] }
    provider { 'facebook' }
    uid { Faker::Internet.unique.uuid }

    trait :admin do
      role { :admin }
    end

    trait :user do
      role { :user }
    end

    trait :banned do
      role { :banned }
    end
  end
end
