class RatingQuestionsController < ApplicationController

  before_action :find_rating_question, only: [:show, :update, :destroy]

  def index
    @rating_questions = RatingQuestion.all
  end

  def show; end

  def create
    @rating_question = RatingQuestion.new(question_params)
    if @rating_question.save
      respond_to do |format|
        format.html { redirect_to "/", notice: "Your question has been created." }
        format.json { render :show, status: 201 }
      end
    else
      render json: { errors: @rating_question.errors.messages }, status: 422
    end
  end

  def update
    @rating_question.update(question_params)
    render json: serialize_question(@rating_question)
  end

  def destroy
    @rating_question.destroy
  end

  private

  def serialize_question(question)
    {
      id: question.id.to_s,
      title: question.title,
      tag: question.tag,
    }
  end

  def question_params
    params.require(:rating_question).permit(:title, :tag)
  end

  def find_rating_question
    @rating_question = RatingQuestion.find(params[:id])
    head 404 unless @rating_question
  end

end
