require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get timeline" do
    get :timeline
    assert_response :success
  end

  test "should get friends" do
    get :friends
    assert_response :success
  end

  test "should get test" do
    get :test
    assert_response :success
  end

  test "should get xtra" do
    get :xtra
    assert_response :success
  end

end
