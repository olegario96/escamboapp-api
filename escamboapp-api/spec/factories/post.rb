FactoryBot.define do
  factory :post do
    productName { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    user
    category
  end
end