class PagesController < ApplicationController

  before_filter :login_required, :only => [:news, :community, :visitors]
  before_filter :premium_required, :only => [:news, :visitors]

  def home
    @title = "Home"
    if signed_in?
      redirect_to community_path
    end
  end

  def community
    @title = "News"
    @posts = Post.order("updated_at DESC").all
  end

  def news
    # TODO / add posts on which the current user has commented
    user_ids = Array.new
    user_ids << current_user.id
    current_user.following.each do |f|
      user_ids << f.following_id
    end
    @posts = Post.order("updated_at DESC").find(:all, :conditions => ['user_id in (?)', user_ids])
  end

  def notfound
    @title = "Not Found"
  end

  def visitors
    # TODO - This is ugly
    @title = "Visitors"
    @users = Array.new
    current_user.visitors.order("updated_at desc").each do |v|
      @users << User.find(v.visited_by)
    end
  end

  def premium
    @title = "Get Premium Access"
  end
end
