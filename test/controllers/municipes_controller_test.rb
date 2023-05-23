require "test_helper"

class MunicipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get municipes_index_url
    assert_response :success
  end

  test "should get new" do
    get municipes_new_url
    assert_response :success
  end

  test "should get create" do
    get municipes_create_url
    assert_response :success
  end

  test "should get edit" do
    get municipes_edit_url
    assert_response :success
  end

  test "should get update" do
    get municipes_update_url
    assert_response :success
  end
end
