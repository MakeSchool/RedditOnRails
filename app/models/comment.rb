class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: :true
  belongs_to :user
  has_many :comments, as: :commentable
  default_scope -> { order(created_at: :desc ) }
  validates_presence_of :user_id
  validates_presence_of :commentable
  validates :content, presence: true, length: { minimum: 2, maximum: 5120 }

  accepts_nested_attributes_for :commentable
end
