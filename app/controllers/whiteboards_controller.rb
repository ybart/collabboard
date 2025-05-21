class WhiteboardsController < ApplicationController
  def index
    @whiteboards = Whiteboard.all
  end

  def show
    @whiteboard = Whiteboard.find(params[:id])
  end
end
