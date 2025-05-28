require "test_helper"

class PasskeyTest < ActiveSupport::TestCase
  test "should require user" do
    passkey = Passkey.new(user: nil, label: "Test Device", public_key: "abc123", external_id: "def456")
    assert_not passkey.valid?
    assert_includes passkey.errors[:user], "must exist"
  end

  test "should require label" do
    passkey = Passkey.new(user: users(:alice), label: nil, public_key: "abc123", external_id: "def456")
    assert_not passkey.valid?
    assert_includes passkey.errors[:label], "can't be blank"
  end

  test "should require public_key" do
    passkey = Passkey.new(user: users(:alice), label: "Test Device", public_key: nil, external_id: "def456")
    assert_not passkey.valid?
    assert_includes passkey.errors[:public_key], "can't be blank"
  end

  test "should belong to user" do
    assert_respond_to Passkey.new, :user
  end
end
