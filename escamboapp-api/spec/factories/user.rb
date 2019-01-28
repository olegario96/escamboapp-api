FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    cpf { Faker::CPF.numeric }

    factory :user_with_posts do
      transient do
        posts_count { Faker::Number.between(1, 10) }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end