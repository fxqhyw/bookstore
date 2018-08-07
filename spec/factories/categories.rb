require 'ffaker'

FactoryBot.define do
  factory :category do
    title { FFaker::Lorem.word }
  end
end
