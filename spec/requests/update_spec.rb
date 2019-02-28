require "rails_helper"

RSpec.describe "PUT /ratingQuestions/:id" do

  let(:new_title) { "Hello World" }
  let(:new_tag) { "new tag" }

  context "when the question exists" do

    before do
      post "/rating_questions.json", params: { rating_question: { title: new_title, tag: new_tag } }
    end

    it "returns a 200 OK and only updates the title" do
      question = JSON.parse(response.body)
      put "/rating_questions/#{question["id"]}", params: { rating_question: { title: "Hello Mars" } }
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
