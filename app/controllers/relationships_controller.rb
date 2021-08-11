class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    if Relationship.create(user_id: current_user.id, follow_id: @user.id)
      respond_to do |format|
        format.js { flash[:alert] = "ユーザーをフォローしました" }
      end
    end
  end
     
  def destroy
    @relation = Relationship.find_by(user_id: current_user.id, follow_id: @user.id)
    if @relation.destroy
      respond_to do |format|
        format.js { flash[:alert] = "ユーザーのフォローを解除しました" }
      end
    end
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
