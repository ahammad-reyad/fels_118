class WordsController < ApplicationController
  before_action :logged_in_user
  before_action :not_admin_user

  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find_by id: params[:category_id]
    else
      @category = Category.first
    end
    @words = Word.filter_words(@category, params[:option], current_user)
      .paginate page: params[:page]
  end
end
