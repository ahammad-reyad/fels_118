class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = current_user.following_activities.paginate page: params[:page]
    end
  end

  def help
  end

  def about
  end
end
