require "test_helper"

class UserTest < ActiveSupport::TestCase
  # 1. VALIDATION TESTS
  test "should require email" do
    user = User.new(email: nil, password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should require valid email format" do
    user = User.new(email: "invalid", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  # TODO: Add test to check we cannot login with empty password if webauthn_id is present

  test "should require password" do
    user = User.new(email: "test@example.com", password: nil)

    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  # 2. ASSOCIATION TESTS
  test "should have many passkeys" do
    assert_respond_to User.new, :passkeys
  end

  test "should have many authored post_its" do
    assert_respond_to User.new, :authored_post_its
  end

  # 3. METHOD TESTS
  test "fixture should be valid" do
    user = users(:alice)

    user.validate

    assert_empty user.errors
  end

  test "should authenticate with correct password" do
    assert users(:alice).valid_password?("password123")
  end

  test "passkeys_class should return Passkey class" do
    assert_equal Passkey, User.passkeys_class
  end
end
