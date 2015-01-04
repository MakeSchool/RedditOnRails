# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_list = [
  [ "admin", "imsecure" ],
  [ "user1", "password" ]
]

user_list.each do | username, password |
  User.create( username: username, password: password,
               password_confirmation: password)
end
