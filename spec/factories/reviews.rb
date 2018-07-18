require 'ffaker'

FactoryBot.define do
  factory :review do
    title FFaker::Lorem.phrase
    description FFaker::Lorem.paragraphs
    rating 1
    status FFaker::Lorem.phrase
  end
end
