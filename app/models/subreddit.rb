class Subreddit < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :submissions
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  belongs_to :moderator, class_name: "User"

  validates_uniqueness_of :name, case_sensitive: false
end
