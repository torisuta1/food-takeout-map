class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user

  def create
    #  current_user.relationships.create(user_id: current_user.id, follow_id: params[:user_id])
    @user = User.find(params[:user_id])
    @relation = Relationship.create(user_id: current_user.id, follow_id: @user.id)
    end
     
    
    #    flash[:notice] = 'ユーザーをフォローしました'
    # else
    #   flash.now[:alert] = 'ユーザーのフォローに失敗しました'
    # end

  def destroy
    #  current_user.relationships.find_by(user_id: current_user.id, follow_id: params[:user_id]).destroy
    @user = User.find(params[:user_id])
    @relation = Relationship.find_by(user_id: current_user.id, follow_id: @user.id)
    @relation.destroy
    end
      
    #   flash[:notice] = 'ユーザーのフォローを解除しました'
    # else
    #   flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
    # end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
