class Admin::UsersController < ApplicationController

  def index
    @users = User.includes(:posts).order("created_at DESC").page(params[:page]).per(15)
  end
end