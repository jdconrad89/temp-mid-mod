class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true


  belongs_to :user

  def title_missing?(params)
    params["title"] == ""
  end

  def url_missing?(params)
    params["url"] == ""
  end

  def title_and_url_missing?(params)
    url_missing?(params) && title_missing?(params)
  end
end
