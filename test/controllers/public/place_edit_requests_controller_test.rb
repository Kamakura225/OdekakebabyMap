require "test_helper"

class Public::PlaceEditRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_place_edit_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get public_place_edit_requests_update_url
    assert_response :success
  end
end
