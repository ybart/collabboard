require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "should instantiate" do
    assert_nothing_raised { ApplicationJob.new }
  end
end
