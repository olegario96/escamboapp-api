FactoryBot.define do
  factory :comment do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user
    post
  end
end