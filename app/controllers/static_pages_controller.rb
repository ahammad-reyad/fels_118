class StaticPagesController < ApplicationController

  def home
    if logged_in?
      if admin_user?
        redirect_to admin_users_path
      else
        @activities = current_user.following_activities.paginate page: params[:page]
      end
    end
  end

  def help
  end

  def about
  end
end
