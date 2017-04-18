module ApplicationHelper

  def read?(link)
    link.read == true
  end

  def link_popularity(link)
    return "Top Link" if link.popularity == "top_link"
    return "Hot"      if link.popularity == "hot"
    return ""         if link.popularity == "nothing"
  end

end
