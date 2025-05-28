require "test_helper"

class PostItTest < ActiveSupport::TestCase
  test "should require author" do
    post_it = PostIt.new(content: "Test note", author: nil, whiteboard: whiteboards(:main))
    assert_not post_it.valid?
    assert_includes post_it.errors[:author], "must exist"
  end

  test "should require whiteboard" do
    post_it = PostIt.new(content: "Test note", author: users(:alice), whiteboard: nil)
    assert_not post_it.valid?
    assert_includes post_it.errors[:whiteboard], "must exist"
  end

  test "should belong to author" do
    assert_respond_to PostIt.new, :author
  end

  test "should belong to whiteboard" do
    assert_respond_to PostIt.new, :whiteboard
  end
end
