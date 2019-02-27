require "rails_helper"

RSpec.describe "GET /rating_questions" do

  let(:new_title) { "Hello World" }
  let(:new_tag) { "new tag" }

  let!(:question) do
    RatingQuestion.create!(title: new_title, tag: new_tag)
  end

  context "when the request has a body" do
    let!(:response) do
      post "/rating_questions.json", params: { title: new_title, tag: new_tag }
    end

    it "returns a 201 Created" do
      expect(response.status).to eq(201)
    end

    it "returns the new document" do
      expect(question.is_a?(Hash)).to eq(true)
      expect(question.key?("id")).to eq(true)
      expect(question["title"]).to eq(new_title)
      expect(question["tag"]).to eq(new_tag)
    end
  end

  context "when the request has no body" do
    let!(:response) do
      post "/rating_questions.json"
    end

    it "returns a 400 Bad Request" do
      expect(response.status).to eq(400)
    end
  end

  context "when the request has a blank title" do
    let!(:response) do
      post "/rating_questions.json", params: { title: "" }
    end

    it "returns a 422 Invalid Resource" do
      expect(response.status).to eq(422)
    end

    it "shows errors that the title cannot be blank" do
      expect(response).to eq({"errors" => {"title" => ["can't be blank"]}})
    end
  end
end
