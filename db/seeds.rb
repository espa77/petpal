# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do
  User.create(email: Faker::Internet.email, password: "1234", name: Faker::Name.name, gender: "Male", birthday: Faker::Date.backward(30000), species: Faker::Team.creature, avatar:Faker::Avatar.image)
end

30.times do
  User.create(email: Faker::Internet.email, password: "1234", name: Faker::Name.name, gender: "Female", birthday: Faker::Date.backward(30000), species: Faker::Team.creature, avatar:Faker::Avatar.image)
end


   