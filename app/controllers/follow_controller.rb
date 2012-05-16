class FollowController < ApplicationController
  def show
    f = Follow.new(:follower => current_user, :following => params[:id])
    f.save
  end

  def destroy
  end
end
