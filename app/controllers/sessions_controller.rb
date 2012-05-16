class SessionsController < ApplicationController
  def new
    @title = "Sign In"
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid Credentials"
      @title = "Sign In"
      render :new
    else
      if user.activated?
        user.update_attributes :remember_me => params[:user][:remember_me], :last_login => Time.now(), :last_activity => Time.now()
        sign_in user
        redirect_to news_path
      else
        flash.now[:error] = "User has not yet been activated. Please check your email for the activation link"
        render :new
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
