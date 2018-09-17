FactoryBot.define do
  factory :book do
    title { FFaker::Lorem.unique.word }
    description { FFaker::Book.description }
    published_at { rand(1999..2018) }
    price 39.99
    materials 'Hardcove, glossy paper'
    height 6.9
    width 5.1
    depth 0.8
    quantity { rand(111..222) }
    category
    authors { FactoryBot.create_list(:author, 2) }
  end
end
