require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "signs up user with password" do
    payload = {
      user: {
        email: "password_user@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert_difference("User.count", 1) do
      post user_registration_path, params: payload
    end

    assert_redirected_to root_path
    assert_equal "password_user@example.com", User.last.email
    assert_nil User.last.webauthn_id # No passkey was created
  end

  test "signs up user with passkey" do
    # Store original method for cleanup
    original_method = Users::RegistrationsController.instance_method(:verify_passkey_registration_challenge)

    # Define mock credential structure
    credential_struct = Struct.new(:public_key, :sign_count, :raw_id, :id)
    mock_credential = credential_struct.new(
      "mock_pk",
      0,
      SecureRandom.random_bytes(16),
      "passkey_123"
    )

    # Mock session registration_user_id
    mock_webauthn_id = SecureRandom.uuid

    # Override controller method to set mock credential and session
    Users::RegistrationsController.define_method(:verify_passkey_registration_challenge) do
      @webauthn_credential = mock_credential
      session["user_current_webauthn_user_id"] = mock_webauthn_id
      true
    end

    begin
      # Test payload without password to ensure passkey flow
      raw_id = SecureRandom.random_bytes(16)
      challenge = SecureRandom.random_bytes(32)
      attestation_object = SecureRandom.random_bytes(64)

      payload = {
        user: {
          email: "passkey_user@example.com",
          passkey_label: "Work Laptop",
          passkey_credential: {
            type: "public-key",
            id: "passkey_123",
            rawId: Base64.urlsafe_encode64(raw_id, padding: false),
            authenticatorAttachment: "platform",
            response: {
              clientDataJSON: Base64.strict_encode64({
                type: "webauthn.create",
                challenge: Base64.urlsafe_encode64(challenge, padding: false),
                origin: "https://collabboard.tpk.dev"
              }.to_json),
              attestationObject: Base64.urlsafe_encode64(attestation_object, padding: false),
              transports: [ "internal" ]
            }
          }.to_json
        }
      }

      assert_difference("User.count", 1) do
        post user_registration_path, params: payload
      end

      assert_redirected_to root_path
      user = User.last
      assert_equal "passkey_user@example.com", user.email
      assert_not_nil user.webauthn_id, "webauthn_id should be set for passkey users"
      assert_equal mock_webauthn_id, user.webauthn_id, "webauthn_id should match session value"
    ensure
      # Restore original method
      Users::RegistrationsController.define_method(:verify_passkey_registration_challenge, original_method)
    end
  end
end
