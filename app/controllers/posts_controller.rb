class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(15)
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if params[:image_files][:file].present?
        params[:image_files][:file].each do |a|
          @image_file = @post.images.create!(image: a, post_id: @post.id)
        end
      end
      flash[:notice] = "投稿が完了しました"
      redirect_to root_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to my_post_post_path(current_user)
    flash[:notice] = "投稿が削除されました"
  end

  def show
    @post = Post.find_by(params[:id])
    
  end

  def search
    @posts = Post.search(params[:search], params[:genre_id]).order("created_at DESC").page(params[:page]).per(10)
  end

  def my_post
    @posts = Post.where(user_id: params[:id]).order("created_at DESC").page(params[:page]).per(10)
  end

private

  def post_params 
    params.require(:post).permit(:title, :content, :genre_id, images_attributes: [:image])
  end

end
