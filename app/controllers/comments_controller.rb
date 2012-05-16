class CommentsController < ApplicationController
  def create
    @comment = Comment.new(:post_id => params[:comment][:post_id], :user_id => current_user.id, :comment => params[:comment][:comment]);
    unless(@comment.comment.blank?)
      @comment.save
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def update
  end
end
