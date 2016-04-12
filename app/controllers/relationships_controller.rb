class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :create_follow_activity, only: [:create]
  before_action :create_unfollow_activity, only: [:destroy]

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

  private
  def create_follow_activity
    user = User.find params[:followed_id]
    Activity.create user_id: current_user.id, details:
      I18n.t("started_following", follower_name: current_user.name,
      name: user.name)
  end

  def create_unfollow_activity
    user = Relationship.find(params[:id]).followed
    Activity.create user_id: current_user.id, details:
      I18n.t("started_unfollowing", unfollower_name: current_user.name,
      name: user.name)
  end
end
