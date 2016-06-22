class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
    @all_secrets = Secret.all
  end

  def create
    secret = Secret.new(secret_params)
    if secret.save
      redirect_to current_user
    else
      flash[:error] = "missing content"
      redirect_to current_user
    end
  end

  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy if @secret.user == current_user
    redirect_to current_user
  end

  private
    def secret_params
      params.require(:secret).permit(:content).merge(user: current_user)
    end
end
