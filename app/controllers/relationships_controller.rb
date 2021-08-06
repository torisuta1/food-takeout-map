class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.relationships.create(follow_id: params[:user_id])
       redirect_to [:user, { id: params[:user_id] }]
       flash[:notice] = 'ユーザーをフォローしました'
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to [:user, { id: params[:user_id] }]
    end
  end

  def destroy
    if current_user.relationships.find_by(follow_id: params[:user_id]).destroy
      redirect_to [:user, { id: params[:user_id] }]
      flash[:notice] = 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to [:user, { id: params[:user_id] }]
    end
  end
end
