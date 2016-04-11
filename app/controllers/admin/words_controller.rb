class Admin::WordsController < ApplicationController
  before_action :admin_user, only: [:index, :new, :edit, :update, :create]

  def index
    @words = Word.paginate page: params[:page]
  end

  def new
    @categories = Category.all
    @word = Word.new
    @word.answers.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t :word_created
      redirect_to admin_words_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params
      flash[:success] = t :word_updated
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    @word = Word.find params[:id]
    @word.destroy
    flash[:success] = t :category_deleted
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
