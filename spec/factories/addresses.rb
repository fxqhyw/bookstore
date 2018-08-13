FactoryBot.define do
  factory :address do
    first_name { FFaker::Lorem.word }
    last_name { FFaker::Lorem.word }
    address { FFaker::Address.street_name }
    city { FFaker::Address.city }
    zip '7777'
    country { FFaker::Address.country }
    phone '+387878322332'
    type 'BillingAddress'
    user
  end
end
