class UsersController < ApplicationController

  def tweets
   @user = User.find(params[:id])
   @tweet = Tweet.new
   @tweets = @user.tweets.all
  end



  def edit
    @user = User.find(params[:id])

    unless @user == current_user
      redirect_to tweets_user_path(@user)
    end

  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    
    redirect_to tweets_user_path(@user)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(6).order('followships.created_at DESC') # 基於測試規格，必須講定變數名稱
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(6).order('followships.created_at DESC') # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets.page(params[:page]).per(6).order('likes.created_at DESC') # 基於測試規格，必須講定變數名稱
    @tweets = @user.tweets


  end

  def show
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end
end
