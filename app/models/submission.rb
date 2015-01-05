class Submission < ActiveRecord::Base
  belongs_to :postable, :polymorphic => :true, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates_presence_of :postable

  accepts_nested_attributes_for :postable

end
