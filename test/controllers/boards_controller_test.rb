require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get boards_new_url
    assert_response :success
  end

end
