FactoryBot.define do
  factory :book do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraph }
    published_at { rand(1999..2018) }
    price { rand(21.99..42.99) }
    materials { 'Hardcove, glossy paper' }
    height { rand(7.3..12.3) }
    width { rand(4.7..8.1) }
    depth { rand(0.4..1.4) }
    quantity { rand(111..222) }
    category
    authors { FactoryBot.create_list(:author, 2) }
  end
end
