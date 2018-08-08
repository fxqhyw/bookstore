FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraphs }
    rating 1
    status :unprocessed
  end
end
