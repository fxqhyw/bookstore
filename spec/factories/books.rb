require 'ffaker'

FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    published_at { FFaker::Vehicle.year }
    price { FFaker::Vehicle.engine_displacement }
    materials 'Hardcove, glossy paper'
    height 6.4
    width 0.9
    depth 5.0
  end
end