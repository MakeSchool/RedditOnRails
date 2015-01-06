# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "admin",
             password: "imsecure",
             password_confirmation: "imsecure",
             admin: true)

99.times do |n|
  username = Faker::Internet.user_name
  while !!User.find_by(username: username) # hack to skip taken usernames
    username = Faker::Internet.user_name
  end
  password = "password"
  User.create!(username:  username,
               password:  password,
               password_confirmation: password)
end

sub1 = Subreddit.create(name: "LearnCS", moderator: User.first)
sub2 = Subreddit.create(name: "random", moderator: User.second)
Subscription.create(user: User.first, subreddit: sub)

link = Link.create(url: "http://makeschool.com")
Submission.create(user: User.first, postable: link,
                  title: "Awesome resource for learning CS",
                  subreddit: sub)

link = Link.create(url: "http://makeschool.com/gapyear")
Submission.create(user: User.first, postable: link,
                  title: "College alternative for hackers",
                  subreddit: sub)

link = Link.create(url: "http://makeschool.com/apply")
Submission.create(user: User.first, postable: link,
                  title: "Applications open now!",
                  subreddit: sub)

link = Link.create(url: "http://makeschool.com/summeracademy")
Submission.create(user: User.first, postable: link,
                  title: "Fun way to learn how to make iOS apps",
                  subreddit: sub)
