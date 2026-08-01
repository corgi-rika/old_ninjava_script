require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = users(:one)
    sign_in user
    get user_url(user)
    assert_response :success
  end
end
