class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    return unless current_user

    current_user.like_tweets << tweet unless tweet.likes.exists?(user_id: current_user.id)
    redirect_to params[:redirect_to] || root_path
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy if like.user_id == current_user.id
    redirect_to params[:redirect_to] || root_path
  end
end
