class RatingQuestionsController < ApplicationController

  def index
    @rating_questions = RatingQuestion.all
  end

  def show
    @rating_question = RatingQuestion.find(params[:id])
    head 404 unless @rating_question
  end

  def create
    @rating_question = RatingQuestion.new(question_params)
    if @rating_question.save
      render :show, status: 201
    else
      render json: { errors: @rating_question.errors.messages }, status: 422
    end
  end

  # def update
  #   @rating_question = RatingQuestion.find(params[:id])
  #   return send_response(response, 404, nil) if @rating_question.nil?
  #   send_response(response, 200, @rating_question)
  # end

  # def edit
  #   @rating_question = RatingQuestion.find(params[:id])
  # end

  def destroy
    rating_question = RatingQuestion.find(params[:id])
    if rating_question.nil?
      head 404
    else
      rating_question.destroy
    end
  end

  private

  def question_params
    params.require(:rating_question).permit(:title, :tag)
  end

end
