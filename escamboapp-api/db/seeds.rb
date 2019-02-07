# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts('Creating categories...')
categories = ['Animals and accessories',
              'Sports',
              'For your home',
              'Eletronics and phones',
              'Music and hobbies',
              'Babys and kids',
              'Fashion and beauty',
              'Vehicles and boats',
              'Properties',
              'Jobs and business']

categories.each do |category|
  Category.find_or_create_by(name: category)
end

puts('Categories created!')

puts('Creating permissions...')
permissions = %w(Read Write Delete)

permissions.each do |permission|
  Permission.find_or_create_by(permission: permission)
end

puts('Permissions created!')

permission_ids = Permission.all.map(&:id)

puts('Creating administrator...')

User.create!(name: 'Admin', email: 'admin@admin.com',
             password: '123456', password_confirmation: '123456',
             cpf: Faker::CPF.numeric, permission_ids: permission_ids)

puts('Creating default user...')

user = User.create!(name: Faker::Name.name, email: 'user@user.com',
                    password: '123456', password_confirmation: '123456',
                    cpf: Faker::CPF.numeric)
user.avatar.attach(io: File.open('./public/templates/images-for-user/profile.png'), filename: 'profile.png')
user.save!

puts('Creating users...')

500.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: Faker::CPF.numeric,
    password: '123456',
    password_confirmation: '123456'
  )
end

100.times do
  Post.create!(
    productName: Faker::Lorem.sentence([2,3,4,5].sample),
    description: Faker::Lorem.paragraph([1,2,3,4].sample),
    user_id: User.all.sample.id,
    category_id: Category.all.sample.id,
    price: "#{Random.rand(5000)}.#{Random.rand(99)}"
  )
end

5.times do
  post = Post.create!(
    productName: Faker::Lorem.sentence([2,3,4,5].sample),
    description: Faker::Lorem.paragraph([1,2,3,4].sample),
    user_id: user.id,
    category_id: Category.all.sample.id,
    price: "#{Random.rand(5000)}.#{Random.rand(99)}"
  )

  photo = "img#{Random.rand(1..15)}.jpg"
  post.images.attach(io: File.open("./public/templates/images-for-product/#{photo}"), filename: "#{photo}")
  photo = "img#{Random.rand(15)}.jpg"
  post.images.attach(io: File.open("./public/templates/images-for-product/#{photo}"), filename: "#{photo}")
end


puts('Users created!')
