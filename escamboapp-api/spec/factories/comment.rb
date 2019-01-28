FactoryBot.define do
  factory :comment do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    rating { Faker::Number.between(1, 5) }
    post
    user
  end
end