class FollowsController < ApplicationController
  def create
    @follow = current_user.follows.new(follow_params)
    if @follow.save!
      redirect_to User.find(params[:user_id])
    else
      redirect_to users_path
    end
  end

  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy

    redirect_to users_path
  end

  private

  def follow_params
    {user1: User.find(params[:user_id])}
  end
end
