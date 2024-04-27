# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { Faker::Name.name }
    text { Faker::Lorem.sentence }
    post
  end
end
