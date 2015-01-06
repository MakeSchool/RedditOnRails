class Submission < ActiveRecord::Base
  belongs_to :postable, polymorphic: :true, dependent: :destroy
  belongs_to :user
  belongs_to :subreddit
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  default_scope -> { order(score: :desc) }
  validates_presence_of :user_id
  validates :title, presence: true, length: { minimum: 2, maximum: 140 }
  validates_presence_of :postable

  accepts_nested_attributes_for :postable

  def total_upvotes
    votes.where(upvote: true).count - votes.where(upvote: false).count
  end

  def update_score(gravity)
    votes = self.total_upvotes
    age = Time.diff(Time.now, self.created_at)[:hour]
    score = votes / (age + 2) ** gravity * 1000
    self.update_attribute(:score, score)
  end

  def Submission.update_scores
    Submission.all.each do |submission|
      submission.update_score(1.8)
    end
  end

end
