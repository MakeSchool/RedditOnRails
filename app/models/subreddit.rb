class Subreddit < ActiveRecord::Base
  before_validation :generate_slug, on: :create

  validates :title, presence: true, length: { minimum: 1, maximum: 21 },
            uniqueness: { case_sensitive: false }
  validates :slug, presence: true, length: { minimum: 1, maximum: 21 },
            uniqueness: { case_sensitive: false }, format: /\A[A-Za-z0-9]*\Z/

  has_many :articles
  belongs_to :user
  has_many :moderators

  private

    def generate_slug
      self.slug = title.downcase.gsub(/[^A-Za-z0-9]/, "")
    end
end
