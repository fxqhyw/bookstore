FactoryBot.define do
  factory :order do
    total_price nil
    status 'in_progress'
    user
    factory :order_with_delivery do
      delivery
    end

    trait :in_queue do
      total_price { rand(20..50) }
      status 'in_queue'
      number 'R111'
    end

    trait :in_delivery do
      total_price { rand(20..50) }
      status 'in_delivery'
      number 'R222'
    end

    trait :delivered do
      total_price { rand(20..50) }
      status 'delivered'
      number 'R333'
    end
  end
end
