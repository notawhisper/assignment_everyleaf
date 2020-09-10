# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'admin',
             email: 'admin@test.com',
             admin: true,
             password: 'password',
             password_confirmation: 'password',
             )


10.times do |n|
  name = Faker::TvShows::GameOfThrones.character
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

10.times do |n|
  title = Faker::TvShows::GameOfThrones.city
  description = Faker::TvShows::GameOfThrones.quote
  priority = rand(2)
  deadline = "200#{n}-09-10 00:00:00"
  user_id = rand(1..11)
  Task.create!(title: title,
               description: description,
               priority: priority,
               deadline: deadline,
               user_id: user_id
               )
end

10.times do |n|
  name = Faker::TvShows::GameOfThrones.house
  Label.create!(name: name,
               )
end
