FactoryBot.define do
  factory :order do
    total_price nil
    status :in_progress
    user
    factory :order_with_delivery do
      delivery
    end
  end
end
