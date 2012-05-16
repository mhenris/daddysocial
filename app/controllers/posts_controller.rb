class PostsController < ApplicationController

  before_filter :login_required
  before_filter :current_user_required, :only => [:destroy]

  def create
    post = Post.new(:user => current_user, :body => params[:post][:body])
    unless params[:post][:image].blank?
      post.image = params[:post][:image]
    end
    unless params[:post][:image_id].nil?
      post.image = UserImage.find(params[:post][:image_id]).image.file
    end
    post.save
    redirect_to community_path
  end

  def destroy
    Post.find(params[:id]).delete
    flash[:success] = "Post successfully deleted"
    redirect_to community_path
  end

  private

    def current_user_required
      Post.find(params[:id]).user_id == current_user.id ? true : unauthorized
    end
end
