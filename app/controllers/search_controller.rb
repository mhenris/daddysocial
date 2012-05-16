class SearchController < ApplicationController
  def new
    @search = UserSearch.new
  end

  def create
    u = UserSearch.new(params[:user_search])
    u.save
    redirect_to search_path(u)
  end

  def show
    @search = UserSearch.find(params[:id])
  end
end
