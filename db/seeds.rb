# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "admin",
             email: "",
             password: "imsecure",
             password_confirmation: "imsecure",
             admin: true)

99.times do |n|
  username = Faker::Internet.user_name
  while !!User.find_by(username: username) # hack to skip taken usernames
    username = Faker::Internet.user_name
  end
  email = ""
  password = "password"
  User.create!(username:  username,
               email:     email,
               password:  password,
               password_confirmation: password)
end
