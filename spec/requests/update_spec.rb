require "rails_helper"

RSpec.describe "PUT /ratingQuestions/:id" do

  let(:new_title) { "Hello World" }
  let(:new_title) { "new tag" }

  context "when the question exists" do

    let!(:question) { RatingQuestion.create!(title: new_title, tag: new_title) }

    it "returns a 200 OK and only updates the title" do
      put "/rating_questions/#{question["id"]}.json", params: { rating_question: { title: "Hello Mars" } }
      updated_question = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(updated_question.is_a?(Hash)).to eq(true)
      expect(updated_question["title"]).to eq("Hello Mars")
      expect(updated_question.key?("tag")).to be true
    end
  end

  context "asking to PUT a question that doesn't exist" do
    it "returns a 404 Not Found" do
      put "/rating_questions/i-will-never-exist", params: { rating_question: { title: "Hello World" } }
      expect(response.status).to eq(404)
    end
  end
end
