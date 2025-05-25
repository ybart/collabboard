class PostItsController < ApplicationController
  before_action :set_whiteboard
  before_action :set_post_it, only: [ :update, :destroy ]

  def create
    @post_it = @whiteboard.post_its.new(post_it_params)
    if @post_it.save
      render json: @post_it, status: :created
    else
      render json: @post_it.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post_it.update(post_it_params)
      render json: @post_it
    else
      render json: @post_it.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post_it.destroy
    head :no_content
  end

  private

  def set_whiteboard
    @whiteboard = Whiteboard.find(params[:whiteboard_id])
  end

  def set_post_it
    @post_it = @whiteboard.post_its.find(params[:id])
  end

  def post_it_params
    params.require(:post_it).permit(:content, :x, :y, :color, :author)
  end
end
