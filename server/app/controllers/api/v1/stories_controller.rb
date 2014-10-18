class Api::V1::StoriesController < ApplicationController
  def index
    @stories = Story.sorted
    render :json => @stories
  end

  def show
    @story = Story.find(params[:id])

    render :json => @story
  end
end
