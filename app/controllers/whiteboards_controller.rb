class WhiteboardsController < ApplicationController
  def index
    @whiteboards = Whiteboard.all
  end
end
