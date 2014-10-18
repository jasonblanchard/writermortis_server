class Api::V1::StoriesController < ApplicationController
  def index
    @stories = Story.sorted
    render :json => @stories
  end
end
