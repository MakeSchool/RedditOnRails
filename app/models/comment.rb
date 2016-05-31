class Comment < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable, presence: true
end
