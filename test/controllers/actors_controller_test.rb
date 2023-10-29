require "test_helper"

class ActorsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get actors_create_url
    assert_response :success
  end

  test "should get update" do
    get actors_update_url
    assert_response :success
  end
end
