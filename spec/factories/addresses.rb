FactoryBot.define do
  factory :address do
    first_name { FFaker::Lorem.word }
    last_name { FFaker::Lorem.word }
    address { FFaker::Lorem.word }
    city { FFaker::Lorem.word }
    zip '7777'
    country { FFaker::Address.country }
    phone '+387878322332'
    type 'BillingAddress'
    user
    order nil
  end
end
