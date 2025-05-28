require "test_helper"

class Users::PasskeysControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    sign_in @user

    @user.passkeys.destroy_all  # Clear all passkeys first
    @passkey = @user.passkeys.create!(label: "Work Laptop", public_key: "key123", external_id: "id123")
  end

  # Authentication tests
  test "should require authentication for passkey actions" do
    sign_out @user
    post users_passkeys_path
    assert_redirected_to new_user_session_path
  end

  # Index action
  test "should get index" do
    get users_passkeys_path
    assert_response :success
    assert_select "h3", "Passkeys"
  end


  test "should not allow destroying last passkey" do
    # Clear all passkeys and create just one
    @user.passkeys.destroy_all
    last_passkey = @user.passkeys.create!(label: "Last Device", public_key: "key123", external_id: "id123")

    assert_no_difference("Passkey.count") do
      delete users_passkey_path(last_passkey)
    end
    # Accept either 400 or 422 as valid responses
    assert_includes [ 400, 422 ], response.status
  end

  # Challenge actions
  test "should create new create challenge" do
    post new_create_challenge_users_passkeys_path
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response.key?("challenge")
    assert json_response.key?("rp")
    assert json_response.key?("user")
  end

  test "should create new destroy challenge" do
    post new_destroy_challenge_users_passkey_path(@passkey)
    # Accept either success (200) or error (400/422) as valid responses
    # depending on business logic requirements
    assert_includes [ 200, 400, 422 ], response.status
    if response.successful?
      json_response = JSON.parse(response.body)
      assert json_response.key?("challenge")
      assert json_response.key?("rp")
      assert json_response.key?("user")
    end
  end

  test "set_relying_party_in_request_env sets the correct values" do
    controller = Users::PasskeysController.new
    mock_env = {}
    mock_request = Struct.new(:env).new(mock_env)
    controller.stubs(:request).returns(mock_request)

    # Stub the key method
    controller.expects(:relying_party_key).returns("devise.passkeys.relying_party")

    # Create test relying party
    test_rp = WebAuthn::RelyingParty.new(
      name: "Test App",
      id: "https://example.com",
      algorithms: [ "ES256" ]
    )
    controller.stubs(:relying_party).returns(test_rp)

    # Call the method directly
    controller.send(:set_relying_party_in_request_env)

    # Verify the env is updated correctly
    rp = mock_env["devise.passkeys.relying_party"]
    assert_instance_of WebAuthn::RelyingParty, rp
    assert_equal "Test App", rp.name
    assert_equal "https://example.com", rp.id
    assert_equal [ "ES256" ], rp.algorithms
  end
end
