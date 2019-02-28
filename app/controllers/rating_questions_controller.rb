class RatingQuestionsController < ApplicationController

  before_action :find_rating_question, only: [:show, :update, :destroy]

  def index
    @rating_questions = RatingQuestion.all
  end

  def show; end

  def create
    @rating_question = RatingQuestion.new(question_params)
    if @rating_question.save
      render :show, status: 201
    else
      render json: { errors: @rating_question.errors.messages }, status: 422
    end
  end

  def update
    @rating_question.update(question_params)
    render :show
  end

  def destroy
    @rating_question.destroy
  end

  private

  def question_params
    params.require(:rating_question).permit(:title, :tag)
  end

  def find_rating_question
    @rating_question = RatingQuestion.find(params[:id])
    head 404 unless @rating_question
  end

end
