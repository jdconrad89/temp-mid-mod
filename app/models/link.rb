class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true


  belongs_to :user

  enum popularity: [:nothing, :hot, :top_link]

  def self.title_missing?(params)
    params["title"] == ""
  end

  def self.url_missing?(params)
    params["url"] == ""
  end

  def self.title_and_url_missing?(params)
    url_missing?(params) && title_missing?(params)
  end

  def self.correct_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
  end

  def self.update_read_status(link)
    status = params[:read]
    link.update(read: status)
  end

end
