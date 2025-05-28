require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "logs in user with password" do
    post user_session_path, params: {
      user: {
        email: users(:alice).email,
        password: "password123"
      }
    }

    assert_redirected_to root_path
    assert_equal users(:alice).id, session["warden.user.user.key"].first.first
  end

  test "logs in user with passkey" do
    alice = users(:alice)
    passkey = alice.passkeys.first

    # Mock the verify method
    Devise::Strategies::PasskeyAuthenticatable
      .any_instance.stubs(:verify_authentication_and_find_stored_credential).returns(passkey)

    post user_session_path, params: {
      user: {
        email: alice.email,
        passkey_credential: {}.to_json
      }
    }

    assert_redirected_to root_path
    assert_equal alice.id, session["warden.user.user.key"].first.first
  end
end
