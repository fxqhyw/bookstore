FactoryBot.define do
  factory :credit_card do
    name { FFaker::Name.name }
    number { Array.new(16) { rand(1..9) }.join }
    expiration_date '11/22'
    cvv { Array.new(3) { rand(1..9) }.join }
  end
end
