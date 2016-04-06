class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    user = User.find params[:user]
    @title = t params[:type].to_sym
    @users = user.send(params[:type]).paginate(page: params[:page])
  end

  def create
    user = User.find params[:followed_id]
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow user
    redirect_to user
  end
end
