FactoryBot.define do
  factory :order_item do
    book { FactoryBot.create(:book) }
    quantity 1
    order_id nil
    cart { FactoryBot.create(:cart) }
  end
end
