class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t :user_deleted
    redirect_to admin_users_path
  end

  private
  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
