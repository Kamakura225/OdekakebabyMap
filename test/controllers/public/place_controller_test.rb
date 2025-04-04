require "test_helper"

class Public::PlaceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_place_index_url
    assert_response :success
  end

  test "should get show" do
    get public_place_show_url
    assert_response :success
  end

  test "should get new" do
    get public_place_new_url
    assert_response :success
  end

  test "should get create" do
    get public_place_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_place_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_place_update_url
    assert_response :success
  end
end
