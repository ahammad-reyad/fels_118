class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t :category_created
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :category_updated
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t :category_deleted
    redirect_to admin_categories_path
  end

  private
  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end

  def category_params
    params.require(:category).permit :category_name
  end

  def find_category
    @category = Category.find params[:id]
  end
end
