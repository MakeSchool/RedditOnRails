class Submission < ActiveRecord::Base
  belongs_to :postable, polymorphic: :true, dependent: :destroy
  belongs_to :user
  has_many :comments, as: :commentable
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :user_id
  validates :title, presence: true, length: { minimum: 2, maximum: 140 }
  validates_presence_of :postable

  accepts_nested_attributes_for :postable

end
