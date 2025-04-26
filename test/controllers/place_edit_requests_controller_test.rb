require "test_helper"

class PlaceEditRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get publics" do
    get place_edit_requests_publics_url
    assert_response :success
  end
end
