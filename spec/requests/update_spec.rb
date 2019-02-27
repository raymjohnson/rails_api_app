require "rails_helper"

RSpec.describe "PUT /rating_questions/:id" do

  let!(:response) do
    post "/rating_questions.json", params: { title: new_title, tag: new_tag }
  end

  context "when the question exists" do

    it "returns a 200 OK" do
      question = JSON.parse(response.body)
      put("rating_questions/#{question["id"]}", params: { title: "Hello Mars" }.to_json)
      expect(response.status).to eq(200)
    end

    it "changes just the title attribute" do
      question = JSON.parse(response.body)
      put("rating_questions/#{question["id"]}", params: { title: "Hello Mars" }.to_json)
      expect(question.is_a?(Hash)).to eq(true)
      expect(question["title"]).to eq("Hello Mars")
      expect(question.key?("tag")).to be true
    end
  end

  context "asking to PUT a question that doesn't exist" do
    let(:response) do
      put("rating_questions/i-will-never-exist.json", params: { title: "hello"})
    end

    it "returns a 404 Not Found" do
      expect(response.status).to eq(404)
    end
  end
end
