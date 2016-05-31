class Article < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :subreddit
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1 }
  # Note: this regex is imperfect.
  VALID_URL_REGEX = /https?:\/\/[\S]+/
  validates :url, presence: true,
            unless: "body.present?"
  validates :url, absence: true, if: "body.present?"
  validates :body, presence: true, unless: "url.present?"
  validates :body, absence: true, if: "url.present?"
  validates :url, format:  { with: VALID_URL_REGEX }, allow_blank: true
  validates :subreddit, presence: true

  def view_link(own_path)
    (url.nil? or url.empty?)? own_path: url
  end
end
