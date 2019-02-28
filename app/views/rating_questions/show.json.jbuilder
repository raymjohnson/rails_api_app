json.extract! @rating_question, :title, :tag
json.id @rating_question.id.to_s
json.url rating_question_url(@rating_question, format: :json)
