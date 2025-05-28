require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "should instantiate" do
    assert_nothing_raised { ApplicationMailer.new }
  end
end
