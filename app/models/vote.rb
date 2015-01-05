class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: :true
  validates_presence_of :user_id
  validates_presence_of :votable
  validates_uniqueness_of :user_id, scope: :votable
end
