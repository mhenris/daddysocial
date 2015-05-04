class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :destroy_expired_session
  before_filter :update_last_seen, :recent_logins
  before_filter :recent_logins

  def recent_logins
    @recent_logins = User.order("last_login desc").limit(10).where("last_login is not ?", nil)
  end

  def update_last_seen
    if signed_in? 
      User.find(current_user.id).update_attribute(:last_activity, Time.now()) if (Time.now() - current_user.last_activity > 300)
    end
  end  

  def home_path
    if signed_in?
      if current_user.premium?
        news_path
      else
        community_path
      end
    else
      root_path
    end
  end    

end
