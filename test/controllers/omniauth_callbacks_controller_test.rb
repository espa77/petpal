require 'test_helper'

class OmniauthCallbacksControllerTest < ActionController::TestCase
  test "should get facebook" do
    get :facebook
    assert_response :success
  end

  test "should get failure" do
    get :failure
    assert_response :success
  end

end
