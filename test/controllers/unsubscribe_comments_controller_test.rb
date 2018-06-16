require 'test_helper'

class UnsubscribeCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get unsubscribe_comments_new_url
    assert_response :success
  end

end
