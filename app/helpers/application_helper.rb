module ApplicationHelper

  def read?(link)
    link.read == true
  end

  def top_read?(link)
    hot_reads = Link.find_hot_reads
    link["url"] == hot_reads.first["url"]
  end

  def hot_read?(link)
    hot_reads = Link.find_hot_reads
    urls = []
    hot_reads[1..-1].each do |hot_read|
      urls << hot_read["url"]
    end
    urls.include?(link["url"])
  end
end
