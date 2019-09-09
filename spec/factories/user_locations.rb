# frozen_string_literal: true

FactoryBot.define do
  factory :user_location do
    user_id {1}
    location_id {1}
    start_date {Faker::Date.between(1.days.ago, Date.today)}
    end_date {Faker::Date.between(2.days.after(Date.today))}
  end
end
