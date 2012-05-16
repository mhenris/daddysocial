class ImagesController < ApplicationController

  before_filter :login_required

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @image = UserImage.find(params[:id])
  end

  def new
  end

  def create
    i = UserImage.new(params[:user_image])
    i.user_id = current_user.id
    i.save
    redirect_to user_images_path(params[:user_id])
  end

  def destroy
    UserImage.find(params[:id]).delete
    redirect_to user_images_path(params[:user_id])
  end
end
