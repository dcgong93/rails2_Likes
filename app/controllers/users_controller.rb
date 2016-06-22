class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @secrets = @user.secrets.all
    @secrets_liked = @user.secrets_liked
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
