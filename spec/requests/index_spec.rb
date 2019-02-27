require "rails_helper"

RSpec.describe "GET /rating_questions" do
  let!(:question) do
    RatingQuestion.create!(title: "Hello World")
  end

  it "shows a list of rating questions" do
    get "/rating_questions.json"
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json.is_a?(Array)).to be true
    first_question = json.first
    expect(first_question["id"]).to eq(question.id.to_s)
    expect(first_question["title"]).to eq(question.title)
  end
end
