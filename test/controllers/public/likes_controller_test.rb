require "test_helper"

class Public::LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_likes_create_url
    assert_response :success
  end

  test "should get update" do
    get public_likes_update_url
    assert_response :success
  end
end
