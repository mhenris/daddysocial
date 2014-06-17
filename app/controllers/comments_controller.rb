class CommentsController < ApplicationController
  def create
    @comment = Comment.new(:post_id => params[:comment][:post_id], :user_id => current_user.id, :comment => params[:comment][:comment]);
    unless @comment.comment.blank?
      @comment.save
      generate_notifications(@comment)
    end
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

  private
    def generate_notifications(comment)
      postnote = Notification.new(:user => current_user, :is_read => 0, :notification => poster_notification(comment))
      postnote.save unless comment.post.user == current_user
      comment.post.comments.each do |c|
        commentnote = Notification.new(:user => current_user, :is_read => 0, :notification => comment_notification(comment))
        commentnote.save unless comment.user == current_user
      end
    end

    def comment_notification(comment)
      link_to(comment.user.name, user_path(comment.user)) + " also commented on " + link_to(comment.post.user.name+"'s Post", post_path(comment.post))
    end

    def poster_notification(comment)
      link_to(comment.user.name, user_path(comment.user)) + " commented on " + link_to("Your Post", post_path(comment.post))
    end
end
