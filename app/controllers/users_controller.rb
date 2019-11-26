class UsersController < ApplicationController
  before_action :set_user, only: [:connect]

  def index
    if params[:query].present?
      @users = User.where("username ILIKE ?", "%#{params[:query]}%")
    else
      @users = User.all_except(current_user)
    end
  end

  def connect
    if current_user.connect(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end