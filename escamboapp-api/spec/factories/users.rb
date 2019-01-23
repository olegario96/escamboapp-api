FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    cpf { Faker::CPF.numeric }
  end
end