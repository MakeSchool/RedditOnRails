class Link < ActiveRecord::Base
  has_one :submission, as: :postable
  validates_presence_of :url
  validate :url_is_valid_url, on: :create

  def url_is_valid_url
    uri = URI.parse(url)
    if !uri.kind_of?(URI::HTTP)
      errors.add(:url, "must be a valid HTTP/HTTPS URL")
    end
    rescue URI::InvalidURIError
  end

end
