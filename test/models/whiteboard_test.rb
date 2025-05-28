require "test_helper"

class WhiteboardTest < ActiveSupport::TestCase
  test "should be valid with default attributes" do
    whiteboard = Whiteboard.new
    assert whiteboard.valid?
  end

  test "should have many post_its" do
    assert_respond_to Whiteboard.new, :post_its
  end
end
