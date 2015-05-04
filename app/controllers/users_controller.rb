class UsersController < ApplicationController

  before_filter :login_required, :only => [ :notifications, :edit, :update, :index ]
  before_filter :current_user_required, :only => [ :edit, :update ]
  before_filter :create_visitor, :only => [:show]
  before_filter :premium_required, :only => [:favorites, :news]

  def visitors
    # TODO - This is ugly
    @title = "Visitors"
    @users = Array.new
    current_user.visitors.order("updated_at desc").each do |v|
      @users << User.find(v.visited_by)
    end
  end

  def news
    # TODO / add posts on which the current user has commented
    user_ids = Array.new
    user_ids << current_user.id
    current_user.following.each do |f|
      user_ids << f.following_id
    end
    @posts = Post.order("updated_at DESC").where('user_id in (?)', user_ids)
  end

  def community
    @title = "News"
    @posts = Post.order("updated_at DESC").all
  end

  def notifications
    @title = "Notifications"
    @notifications = current_user.notifications
  end

  def map
    @user = User.find(params[:id])
  end 

  def index
    @title = "Users"
    @users ||= User.search(params).page(params[:page]).per(30)
  end

  def show
    @title = "Profile"
    @user = User.find(params[:id])
    @images = @user.images.page(params[:page]).per(16)
    @recent_messages = Message.where("(recipient_id = #{@user.id} and sender_id = #{current_user.id}) OR (sender_id = #{@user.id} and recipient_id = #{current_user.id})").order('created_at desc').limit(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @title = "Edit Profile"
    @user = current_user
  end

  def new
    @title = "Sign Up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if verify_recaptcha(@user) && @user.valid?
      @user.save
      UserNotifier.signup_notification(@user,activate_url(@user.activation_code)).deliver
      flash[:success] = "Thank you for signing up at daddysocial.com! You will receive an email shortly with your activation code"
      redirect_to root_path
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def update
    @user = current_user
    if(@user.update_attributes(params[:user]))
      flash[:success] = "Profile Successfully Updated"
      sign_in @user
      redirect_to @user
    else
      render :edit
    end
  end

  def unfollow
    current_user.following.find_by_following_id(params[:id]).delete
    redirect_to user_path(params[:id])
  end

  def follow
    f = Follow.new(:follower => current_user, :following_id => params[:id])
    f.save
    redirect_to user_path(params[:id])
  end

  def favorites
    @user = User.find(params[:id])
    @users = Array.new
    current_user.following.each do |f|
      @users << f.following
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = Array.new
    @user.followers.each do |f|
      @users << f.follower
    end
  end

  def search
    @title = "Search"
  end

  def activate
    @user = User.find_by_activation_code(params[:activation_code])
    if @user.nil?
      flash[:error] = "User not found or already activated. Try logging in"
    else
      @user.activate
      flash[:success] = "User successfully activated"
    end
    redirect_to login_url
  end

  private

    def create_visitor
      if signed_in?
        unless current_user.id == Integer(params[:id])
          visitor = Visitor.where(["user_id = ? and visited_by = ?", params[:id], current_user.id]).first
          visitor.nil? ? Visitor.new(:user_id => params[:id], :visited_by => current_user.id).save : visitor.touch
        end
      end
    end

    def current_user_required
      current_user.id.to_s == params[:id] ? true : unauthorized
    end
end
