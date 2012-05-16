class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :update_last_seen, :recent_logins

  def recent_logins
    @recent_logins = User.order("last_login desc").limit(10).where("last_login is not ?", nil)
  end

  def update_last_seen
    if signed_in? 
      unless current_user.remember_me
        destroy_expired_session
        return false
      end
      current_user.update_attribute(:last_activity, Time.now()) if (Time.now() - current_user.last_activity > 300)
    end
  end  

end
