class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
    @posts = @user.posts.where(user_id: @user.id).page(params[:page]).per(10)
    @post = Post.find_by(user_id: params[:id])
  end
end
