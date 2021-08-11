class Admin::UsersController < ApplicationController

  def index
    @users = User.includes(:posts).order("created_at DESC").page(params[:page]).per(15)
  end

  def destroy
    if user_logged_in? && current_user.admin?
      @user = User.find(params[:user_id])
      @user.destroy
      redirect_to root_path
      flash[:notice] = "アカウントを削除しました"
    end
  end
end