class MessagesController < ApplicationController

  before_filter :login_required
  # before_filter :message_limit, :only => [:create]
  before_filter :current_user_required, :only => [:show, :destroy]

  def index
    @messages = current_user.messages_received.order('created_at DESC')
  end

  def sent
    @messages = current_user.messages_sent.order('created_at DESC')
  end

  def show
    @message = Message.find(params[:id])
    @recent_messages = Message.where("(recipient_id = #{@message.sender.id} and sender_id = #{current_user.id}) OR (sender_id = #{@message.sender.id} and recipient_id = #{current_user.id})").order('created_at desc').limit(10)
    unless @message.is_read?
      Message.find(params[:id]).update_attribute(:is_read, 1)
    end
  end

  def new
    @recipient = User.find(params[:user_id])
  end

  def create
    @message = Message.new(:sender_id => current_user.id, :recipient_id => params[:user_id], :message => params[:message][:message])
    @message.save unless current_user.message_limit? || @message.message.blank?
    respond_to do |format|
      format.html { 
        flash[:success] = "Message successfully sent"
        redirect_to user_path(params[:user_id])
      }
      format.js
    end
  end

  def destroy
    Message.find(params[:id]).delete
    flash[:success] = "Message Deleted"
    redirect_to inbox_path
  end

  private

    def current_user_required
      m = Message.find(params[:id])
      (m.recipient_id == current_user.id || m.sender_id == current_user.id) ? true : unauthorized
    end
end
