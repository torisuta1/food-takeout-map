class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).page(params[:page])
    @post = Post.find_by(user_id: params[:id])
  end
end
