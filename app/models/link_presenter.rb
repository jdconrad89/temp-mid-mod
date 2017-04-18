class LinkPresenter
  attr_reader :all_links

  def self.link_finder(current_user)
    if current_user
      @all_links = current_user.links.order(created_at: :desc)
      @hot_reads = JSON.parse(Faraday.get("http://https://morning-cliffs-48745.herokuapp.com//api/v1/links").body)
      @all_links.each do |link|
        if link.url == @hot_reads.first["url"]
          link.popularity = 2
        elsif link.url != @hot_reads.first["url"] && does_hot_reads_have_the_link(@hot_reads, link.url)
          link.popularity = 1
        else
          link.popularity = 0
        end
      end

    else
      @all_links = nil
    end
  end

  def self.does_hot_reads_have_the_link(hot_reads, link)
    urls = []
    hot_reads.each do |hot_read|
      urls << hot_read["url"]
    end
    urls.include?(link)
  end
end
