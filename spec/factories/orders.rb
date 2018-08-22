FactoryBot.define do
  factory :order do
    total_price nil
    status :in_progress
    user
  end
end
