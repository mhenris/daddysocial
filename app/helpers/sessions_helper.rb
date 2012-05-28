module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def session_expired?
    # TODO - Don't expire session if the page is not login-required
    signed_in? && !current_user.remember_me && (Time.now() - current_user.last_activity > 1200) && (params[:controller] != 'pages' && params[:controller] != 'sessions')
  end

  def destroy_expired_session
    # TODO - Maybe save the page they tried to visit and go back to it
    if session_expired?
      sign_out
      access_denied
      # flash[:error] = "Your session has expired.  Please log in"
      # redirect_to login_path and return
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def login_required
    signed_in? ? true : access_denied
  end

  def access_denied
    flash[:error] = "You must be logged in to view this page"
    redirect_to login_path
  end

  def premium_required
    unless current_user.premium?
      flash[:error] = "You must be a premium member to view this page"
      redirect_to community_path
    end
  end

  def unauthorized
    redirect_to notfound_path
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

end
