class PostsController < ApplicationController

  before_filter :login_required
  before_filter :current_user_required, :only => [:destroy]

  def show
    @post = Post.find(params[:id]);
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    post = Post.new(:user => current_user, :body => params[:post][:body])
    unless params[:post][:image].blank?
      post.image = params[:post][:image]
    end
    unless params[:post][:image_id].nil?
      post.image = UserImage.find(params[:post][:image_id]).image.file
    end
    post.save
    redirect_to home_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.delete
    @post.delete
    respond_to do |format|
      format.html {
        flash[:success] = "Post successfully deleted"
        redirect_to home_path
      }
      format.js
    end

  end

  private

    def current_user_required
      Post.find(params[:id]).user_id == current_user.id ? true : unauthorized
    end
end
