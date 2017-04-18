class Api::V1::LinksController < ApplicationController

  def create
    link = params["url"]

    if Link.correct_url?(link)
      created_link = current_user.links.new(url: params["url"], title: params["title"]) if Link.correct_url?(link)
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

  def incorrect_information(link)
    flash[:danger] = "You didn't enter a title" if Link.title_missing?
    flash[:danger] = "The url you have entered is incorrect" if Link.correct_url?(link) == true
    flash[:danger] = "You didn't enter a URL" if Link.url_missing?
    flash[:danger] = "You didn't enter any information" if Link.title_and_url_missing?
  end
end
