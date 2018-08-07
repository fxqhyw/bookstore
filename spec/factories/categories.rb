require 'ffaker'

FactoryBot.define do
  factory :category do
    title { FFaker::Lorem.unique.word }
  end
end
