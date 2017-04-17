class Api::V1::LinksController < ApplicationController

  def create
    link = params["url"]
    if correct_url?(link)
      created_link = Link.new(url: params["url"], title: params["title"], user_id: current_user.id) if correct_url?(link)
      if created_link.save
        flash[:danger] = "Link #{link["title"]} has been saved!"
        redirect_to '/'
      else
        incorrect_information(link)
        redirect_to '/'
      end
    else
      incorrect_information(link)
      redirect_to '/'
    end
  end

  def index
    @links = Link.all
    render json: @links, status: 200
  end

  private

  def link_params
    params.permit(:id, :title, :url, :read)
  end

  def correct_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
  end

  def title_missing?
    params["title"] == ""
  end

  def url_missing?
    params["url"] == ""
  end

  def title_and_url_missing?
    url_missing? && title_missing?
  end

  def incorrect_information(link)
    flash[:danger] = "You didn't enter a title" if title_missing?
    flash[:danger] = "The url you have entered is incorrect" if !correct_url?(link)
    flash[:danger] = "You didn't enter a URL" if url_missing?
    flash[:danger] = "You didn't enter any information" if title_and_url_missing?
  end
end
