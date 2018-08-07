FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip '7777'
    country { FFaker::Address.country }
    phone '+387878322332'
    type 'BillingAddress'
    user
  end
end
