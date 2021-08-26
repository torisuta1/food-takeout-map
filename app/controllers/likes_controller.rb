class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = Like.create(post_id: @post.id, user_id: current_user.id)
  end

  def destroy
    @like = Like.find_by(post_id: @post.id, user_id: current_user.id)
    @like.destroy
  end

 private
   def set_post
     @post = Post.find(params[:post_id])
   end
end
