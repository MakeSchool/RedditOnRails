class Subreddit < ActiveRecord::Base
  has_many :submissions
  has_many :subscriptions
  has_many :users, through: :subscriptions
  belongs_to :moderator, class_name: "User"
end
