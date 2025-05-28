class PostIt < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :author, class_name: "User"
  belongs_to :whiteboard

  validates :content, presence: true
  validates :x, :y, numericality: true
  validates :color, presence: true

  after_create_commit :broadcast_create
  after_update :broadcast_update
  after_destroy :broadcast_destroy

  private

  def broadcast_create
    broadcast_append_to(
      whiteboard,
      partial: "post_its/post_it",
      locals: { post_it: self },
      target: dom_id(whiteboard)
    )
  end

  def broadcast_update
    ActionCable.server.broadcast(
      "whiteboard_#{whiteboard_id}",
      {
        action: "update",
        post_it: self
      }
    )
  end

  def broadcast_destroy
    ActionCable.server.broadcast(
      "whiteboard_#{whiteboard_id}",
      {
        action: "destroy",
        post_it: self
      }
    )
  end
end
