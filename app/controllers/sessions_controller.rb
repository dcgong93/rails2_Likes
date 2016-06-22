class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:Email])
    if user && user.authenticate(params[:Password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      flash[:errors] = ["Invalid"]
      redirect_to new_session_path
    end
  end

  def login
    redirect_to user_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

end
