require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    sign_in users(:one)
    get root_url
    assert_response :success
  end
end
