require "test_helper"

class Admin::PlaceEditRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_place_edit_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_place_edit_requests_show_url
    assert_response :success
  end

  test "should get approve" do
    get admin_place_edit_requests_approve_url
    assert_response :success
  end

  test "should get reject" do
    get admin_place_edit_requests_reject_url
    assert_response :success
  end
end
