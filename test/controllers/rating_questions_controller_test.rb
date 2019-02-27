require 'test_helper'

class rating_questionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rating_questions_index_url
    assert_response :success
  end

end
