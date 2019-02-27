class RatingQuestionsController < ApplicationController

  def index
    @rating_questions = RatingQuestion.all
  end

  def show
    @rating_question = RatingQuestion.find(params[:id])
  end

  def create
    body_content = request.body.read
    return send_response(response, 400, nil) if body_content.empty?
    @rating_question = RatingQuestion.create(question_params)
    if new_question.persisted?
      send_response(response, 201, @rating_question)
    else
      errors = { "errors" => @rating_question.errors.messages }
      send_response(response, 422, errors )
    end
  end

  def update
    @rating_question = RatingQuestion.find(params[:id])
    return send_response(response, 404, nil) if @rating_question.nil?
    send_response(response, 200, @rating_question)
  end

  def edit
    @rating_question = RatingQuestion.find(params[:id])
  end

  def destroy
    rating_question = RatingQuestion.find(params[:id])
    rating_question.destroy
  end

  private

    def question_params
      params.require(:rating_questions).permit(:title, :tag)
    end

    def send_response(response, status, body)
      response.status = status
      response.body = body.to_json
      response
    end

end
