FactoryBot.define do
  factory :delivery do
    type { FFaker::Lorem.phrase }
    price { rand 4.99..14.99 }
    duration 'few days'
  end
end
