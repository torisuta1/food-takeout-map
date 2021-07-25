class PostsController < ApplicationController
  before_action :authenticate_user!
  

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to root_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @posts = Post.where(user_id: params[:id]).page(params[:page]).per(10)
  end

private

  def post_params 
    params.require(:post).permit(:title, :content)
  end

end
