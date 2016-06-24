class LikesController < ApplicationController
  before_action :require_login, only:[:create, :destroy]


  def create
    secret = Secret.find(params[:secret_id])
    like = Like.create(user: current_user, secret: secret)
    redirect_to '/secrets'
  end

  def destroy
    like = Like.find(params[:id])
    if current_user == like.user
      like.destroy
      redirect_to '/secrets'
    else
      redirect_to '/secrets'
    end
  end

end
