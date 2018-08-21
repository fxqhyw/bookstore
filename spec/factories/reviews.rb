FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraphs }
    rating 1
    book
    user
  end
end
