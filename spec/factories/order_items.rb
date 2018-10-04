FactoryBot.define do
  factory :order_item do
    book
    quantity { 1 }
    order
  end
end
