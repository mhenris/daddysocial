class CommentsController < ApplicationController
  def create
    @comment = Comment.new(:post_id => params[:comment][:post_id], :user_id => current_user.id, :comment => params[:comment][:comment]);
    @comment.save unless(@comment.comment.blank?)
    respond_to do |format|
      format.html { redirect_to home_path }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    respond_to do |format|
      format.html { 
        flash[:success] = "Comment successfully deleted"
        redirect_to home_path 
      }
      format.js
    end
  end
  def update
  end
end
