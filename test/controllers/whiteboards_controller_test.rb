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
end
