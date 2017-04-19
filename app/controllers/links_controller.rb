class LinksController < ApplicationController
  before_action :authorized?

  def index
    @links = LinkPresenter.link_finder(current_user)
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if params[:link] == nil
      Link.update_read_status(@link, params)
    elsif Link.correct_url?(params["link"]["url"])
      if @link.update(link_params)
        flash[:success] = "Your link has been updated!"
        redirect_to '/'
      else
        incorrect_information(@link)
        redirect_to edit_link_path(@link)
      end
    else
      incorrect_information(@link)
      redirect_to edit_link_path(@link)
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end

  def incorrect_information(link)
    flash[:danger] = "You didn't enter a title" if Link.title_missing?(params)
    flash[:danger] = "The url you have entered is incorrect" if Link.correct_url?(link["url"]) == true
    flash[:danger] = "You didn't enter a URL" if Link.url_missing?(params)
    flash[:danger] = "You didn't enter any information" if Link.title_and_url_missing?(params)
  end
end
