class PagesController < ApplicationController

  before_filter :login_required, :only => [:news, :community, :visitors]
  before_filter :premium_required, :only => [:news, :visitors]

  def home
    @title = "Home"
    if signed_in?
      redirect_to home_path
    end
  end

  def notfound
    @title = "Not Found"
  end

  def premium
    @title = "Get Premium Access"
  end
end
