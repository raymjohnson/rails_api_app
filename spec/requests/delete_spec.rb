require "rails_helper"

RSpec.describe "DELETE /rating_questions/:id" do

  context "with an existing question" do
    it "returns a 204 No Content" do
      post("/rating_questions.json", params: { title: "Hello World" })
      question = JSON.parse(response.body)
      delete("/#{question["id"]}")
      expect(response.status).to eq(204)
    end

    it "returns nothing" do
      post("/rating_questions.json", params: { title: "Hello World" })
      question = JSON.parse(response.body)
      delete("/#{question["id"]}")
      expect(response.body.to_s).to eq('')
    end
  end

  context "asking to delete a question that doesn't exist" do
    it "returns a 404 Not Found" do
      delete "/i-will-never-exist"
      expect(response.status).to eq(404)
    end
  end

  context "with an existing question" do
    let(:question) do
      response = post("/rating_questions.json", params: { title: "Hello World" })
      response.parse
    end

    it "actually deletes the question" do
      route = "rating_questions/#{question["id"]}.json"
      delete(route)
      response = get(route)
      expect(response.status).to eq(404)
    end
  end
end
