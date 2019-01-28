FactoryBot.define do
  factory :post do
    productName { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    user
    category

    factory :post_with_comments do
      transient do
        comments_count { Faker::Number.between(1, 10) }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end
  end
end