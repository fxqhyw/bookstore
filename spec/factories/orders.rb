FactoryBot.define do
  factory :order do
    total_price nil
    status :in_progress
    delivery
    user
  end
end
