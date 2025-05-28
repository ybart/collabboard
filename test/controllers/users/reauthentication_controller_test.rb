require "test_helper"

class Users::ReauthenticationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    sign_in @user
  end

  test "should require authentication for new challenge" do
    sign_out @user
    post new_user_reauthentication_challenge_path
    assert_redirected_to new_user_session_path
  end

  test "should return success for authenticated challenge request" do
    post new_user_reauthentication_challenge_path
    assert_response :success
  end
end
