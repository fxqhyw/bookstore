FactoryBot.define do
  factory :delivery do
    method { FFaker::Lorem.word }
    price { rand 4.99..14.99 }
    duration 'few days'
  end
end
