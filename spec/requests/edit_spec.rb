require "rails_helper"

RSpec.describe "PATCH /rating_questions/:id" do
  context "when the question exists" do
    let(:question) do
      response = post("rating_questions.json", params: { title: "Hello World" })
      response.parse
    end

    let(:response) do
      patch("rating_questions/#{question["id"]}.json", params: { tag: "greetings" })
    end

    it "returns a 200 OK" do
      expect(response.status).to eq(200)
    end

    it "returns a question -- with an additional field" do
      question = response.parse
      expect(question.is_a?(Hash)).to eq(true)
      expect(question["title"]).to eq("Hello World")
      expect(question["tag"]).to eq("greetings")
    end
  end

  context "asking to get a question that doesn't exist" do
    let(:response) do
      patch("rating_questions/i-will-never-exist.json", params: { title: "not here"})
    end

    it "returns a 404 Not Found" do
      expect(response.status).to eq(404)
    end
  end
end
