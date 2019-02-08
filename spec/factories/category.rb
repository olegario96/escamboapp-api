FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }

    factory :category_with_posts do
      transient do
        posts_count { Faker::Number.between(1, 10) }
      end

      after(:create) do |category, evaluator|
        create_list(:post, evaluator.posts_count, category: category)
      end
    end
  end
end