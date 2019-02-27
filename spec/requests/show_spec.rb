require "rails_helper"

RSpec.describe "GET /rating_questions/:id" do

  let(:new_title) { "Hello World" }
  let(:new_tag) { "new tag" }

  before do
    post "/rating_questions.json", params: { rating_question: { title: new_title, tag: new_tag } }
  end

  context "when the question exists" do

    it "returns a 200 OK" do
      question = JSON.parse(response.body)
      get("/rating_questions/#{question["id"]}")
      expect(response.status).to eq(200)
    end

    it "returns a question" do
      question = JSON.parse(response.body)
      get("/rating_questions/#{question["id"]}")
      expect(question.is_a?(Hash)).to eq(true)
    end
  end

  context "asking to get a question that doesn't exist" do
    it "returns a 404 Not Found" do
      get("/rating_questions/i-will-never-exist")
      expect(response.status).to eq(404)
    end
  end
end
