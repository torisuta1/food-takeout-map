class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.relationships.create(follow_id: params[:user_id])
   redirect_to [:user, { id: params[:user_id] }]
  end

  def destroy
    current_user.relationships.find_by(follow_id: params[:user_id]).destroy
   redirect_to [:user, { id: params[:user_id] }]
  end



end
