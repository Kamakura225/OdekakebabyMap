require "test_helper"

class Public::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get public_home_top_url
    assert_response :success
  end
end
