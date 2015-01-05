class User < ActiveRecord::Base
  has_many :submissions
  has_many :comments
  has_many :votes
  attr_accessor :remember_token

  before_save :downcase_username
  validates :username, presence: true, length: { minimum: 2, maximum: 32 },
                    uniqueness: { case_sensitive: false }
  validates_length_of :password, minimum: 6, maximum: 32

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def vote(votable, upvote)
    @vote = votes.where(votable: votable).first
    if !@vote
      votes.create(votable: votable, upvote: upvote)
    else
      newVote = (@vote.upvote.to_s != upvote)
      unvote(votable)
      if newVote
        votes.create(votable: votable, upvote: upvote)
      end
    end
  end

  def unvote(votable)
    votes.find_by(votable: votable).try(:destroy)
  end

  def voted?(votable)
    votes.include?(votable: votable)
  end

  def upOrDownVoted(votable)
    @vote = votes.where(votable: votable).first
    if !@vote
      0
    elsif @vote.upvote
      1
    else
      -1
    end
  end

  def total_karma
    karma = 0
    self.submissions.each do |submission|
      karma += submission.total_upvotes
    end
    karma
  end

  private
    def downcase_username
      self.username = username.downcase
    end
end
