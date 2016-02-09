# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
array_of_images=['http://www.imgion.com/images/01/Loving-Parrot.jpg','http://r.ddmcdn.com/s_f/o_1/cx_304/cy_0/cw_1194/ch_1194/w_720/APL/uploads/2014/10/healthy-pets-7358968.jpg','http://media2.popsugar-assets.com/files/2011/02/05/3/192/1922243/fbcec04125cd4ba5_pet_template/i/Cute-Pictures-Piglet.jpg','http://brandymillapt.com/wp-content/images/puppies.gif','http://www.petsunlimitedfl.com/files/QuickSiteImages/sam.jpg','http://weeklygravy.com/wp-content/uploads/2014/01/pets.jpg','http://i00.i.aliimg.com/wsphoto/v0/32238280464_1/Cute-Teddy-Puppy-Cloth-Christmas-Deer-Cute-Pet-Thick-Cloth-Puppy-Cloth-Fashion-Clothing-for-Dogs.jpg','https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTDClEdW_WoK9NiWovk329U9DxeYvcTJmhPT3JlrFLrZsBXBb0f','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKYkiTI-5CVhMc5JCn3CfSkdk_ubhP3TubG4I5I6BwmN77ZxUb']
30.times do
  User.create(email: Faker::Internet.email, password: "1234", name: Faker::Name.name, gender: "Male", birthday: Faker::Date.backward(30000), species: Faker::Team.creature, avatar: array_of_images.sample)
end

30.times do
  User.create(email: Faker::Internet.email, password: "1234", name: Faker::Name.name, gender: "Female", birthday: Faker::Date.backward(30000), species: Faker::Team.creature, avatar: array_of_images.sample)
end
