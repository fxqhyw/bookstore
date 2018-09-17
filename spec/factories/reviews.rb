FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph }
    rating { rand(1..5) }
    book
    user
  end
end
