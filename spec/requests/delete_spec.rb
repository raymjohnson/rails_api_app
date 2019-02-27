require "rails_helper"

RSpec.describe "DELETE /rating_questions/:id" do

  let(:new_title) { "Hello World" }

  context "with an existing question" do

    before do
      post "/rating_questions.json", params: { rating_question: { title: new_title } }
    end

    it "returns a 204 No Content" do
      question = JSON.parse(response.body)
      delete("/rating_questions/#{question["id"]}.json")
      expect(response.status).to eq(204)
    end

    it "returns nothing" do
      question = JSON.parse(response.body)
      delete("/rating_questions/#{question["id"]}")
      expect(response.body.to_s).to eq('')
    end
  end

  context "asking to delete a question that doesn't exist" do
    it "returns a 404 Not Found" do
      delete "/rating_questions/i-will-never-exist"
      expect(response.status).to eq(404)
    end
  end

  context "with an existing question" do
    let(:question) do
      post("/rating_questions.json", params: { rating_question: { title: new_title, tag: "" } })
      JSON.parse(response.body)
    end

    it "actually deletes the question" do
      route = "/rating_questions/#{question["id"]}.json"
      delete(route)
      get(route)
      expect(response.status).to eq(404)
    end
  end
end
