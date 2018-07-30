FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { Ffaker::Mame.last_name }
  end
end
