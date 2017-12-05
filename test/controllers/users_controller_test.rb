require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get followers" do
    get :followers
    assert_response :success
  end

  test "should get followings" do
    get :followings
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
