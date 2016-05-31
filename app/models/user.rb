class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :comments
  has_many :subreddits

  has_many :moderator_assignments, class_name: "Moderator",
          foreign_key: "user_id"
  has_many :moderating, through: :moderator_assignments, source: :subreddit
  #has_many :moderators, through: :moderator

  def moderates?(subreddit)
    subreddit.user == self || moderating.include?(subreddit)
  end
end
