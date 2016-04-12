class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user

  def index
    @categories = Category.paginate page: params[:page]
  end
end
