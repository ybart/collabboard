require "test_helper"

class WhiteboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixtures = [
      whiteboards(:project_alpha),
      whiteboards(:project_beta),
      whiteboards(:project_gamma)
    ]

    Whiteboard.where.not(id: @fixtures.map(&:id)).destroy_all
  end

  test "index displays exactly the 3 fixture whiteboards" do
    get whiteboards_url
    assert_response :success

    # 3. Verify only fixtures exist
    assert_equal 3, Whiteboard.count
    assert_select ".grid .bg-white", count: 3

    @fixtures.each do |wb|
      assert_select "h3", text: wb.name
      assert_select "img[src*='whiteboard-previews/sample1']"
      assert_select "img[src*='whiteboard-previews/sample2']"
      assert_select "img[src*='whiteboard-previews/sample3']"
    end
  end

  test "should show whiteboard with tools and participants" do
    whiteboard = whiteboards(:project_alpha)
    get whiteboard_url(whiteboard)

    assert_response :success
    assert_select ".flex-1" do  # Whiteboard workspace area
      assert_select "[data-tool='marker']"  # Verify tools exist
      assert_select "[data-tool='post-it']"
    end
    assert_select "h3", "Participants"  # Verify participants section
  end
end
