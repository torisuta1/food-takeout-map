class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:user).where(user_id: params[:id]).order("created_at DESC").page(params[:page]).per(10)
    @post = Post.find_by(user_id: params[:id])
    
  end
end
