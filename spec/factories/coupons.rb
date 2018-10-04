FactoryBot.define do
  factory :coupon do
    code { FFaker::Lorem.word }
    discount { 9.99 }
  end
end
