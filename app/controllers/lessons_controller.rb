class LessonsController < ApplicationController
  before_action :logged_in_user

  def create
    @lesson = current_user.lessons.new lesson_params
    if @lesson.save
      flash[:success] = t :lesson_created
      redirect_to [@lesson.category, @lesson]
    else
      flash[:danger] = t :lesson_created_failed
      redirect_to categories_path
    end
  end

  def show
    @lesson = Lesson.find params[:id]
  end

  def update
    @lesson = Lesson.find_by id: params[:id]
    @lesson.update_attributes lesson_params
    respond_to do |format|
      format.js
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id,
      results_attributes: [:id, :answer_id]
  end
end
