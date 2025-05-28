require "test_helper"

class PostItsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @whiteboard = whiteboards(:main)
    @user = users(:alice)
    @post_it = post_its(:alice_reminder)
    sign_in @user
  end

  test "should create post_it" do
    assert_difference("PostIt.count") do
      post whiteboard_post_its_url(@whiteboard), params: {
        post_it: {
          content: "New note",
          x: 100,
          y: 200,
          color: "yellow"
        }
      }, as: :json
    end

    assert_response :created
    assert_equal "New note", JSON.parse(response.body)["content"]
  end

  test "should not create post_it with invalid params" do
    assert_no_difference("PostIt.count") do
      post whiteboard_post_its_url(@whiteboard), params: {
        post_it: {
          content: "",
          x: nil,
          y: nil,
          color: ""
        }
      }, as: :json
    end

    assert_response :unprocessable_entity
    response_json = JSON.parse(response.body)
    assert_equal [ "can't be blank" ], response_json["content"]
    assert_equal [ "is not a number" ], response_json["x"]
    assert_equal [ "is not a number" ], response_json["y"]
    assert_equal [ "can't be blank" ], response_json["color"]
  end

  test "should update post_it" do
    patch whiteboard_post_it_url(@whiteboard, @post_it), params: {
      post_it: {
        content: "Updated note"
      }
    }, as: :json

    assert_response :success
    assert_equal "Updated note", JSON.parse(response.body)["content"]
  end

  test "should update post_it position" do
    patch whiteboard_post_it_url(@whiteboard, @post_it), params: {
      post_it: {
        x: 300,
        y: 400
      }
    }, as: :json

    assert_response :success
    @post_it.reload
    assert_equal 300, @post_it.x
    assert_equal 400, @post_it.y
  end

  test "should destroy post_it" do
    assert_difference("PostIt.count", -1) do
      delete whiteboard_post_it_url(@whiteboard, @post_it), as: :json
    end

    assert_response :no_content
  end

  test "should not update post_it with invalid params" do
    original_attributes = {
      content: @post_it.content,
      x: @post_it.x,
      y: @post_it.y,
      color: @post_it.color
    }

    patch whiteboard_post_it_url(@whiteboard, @post_it), params: {
      post_it: {
        content: "",
        x: "invalid",
        y: "invalid",
        color: ""
      }
    }, as: :json

    assert_response :unprocessable_entity
    response_json = JSON.parse(response.body)

    assert_equal [ "can't be blank" ], response_json["content"]
    assert_equal [ "is not a number" ], response_json["x"]
    assert_equal [ "is not a number" ], response_json["y"]
    assert_equal [ "can't be blank" ], response_json["color"]

    @post_it.reload
    assert_equal original_attributes[:content], @post_it.content
    assert_equal original_attributes[:x], @post_it.x
    assert_equal original_attributes[:y], @post_it.y
    assert_equal original_attributes[:color], @post_it.color
  end
end
