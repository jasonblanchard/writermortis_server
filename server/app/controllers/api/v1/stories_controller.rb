class Api::V1::StoriesController < ApplicationController
  def index
    @stories = Story.sorted
    render :json => @stories
  end

  def show
    @story = Story.find(params[:id])
    render :json => @story
  end

  def create
    @story = current_user.stories.new(story_params)

    if @story.save
      render :json => @story, :status => 201
    else
      render :json => { :errors => @story.errors.full_messages }, :status => 400
    end
  end

  def update
    @story = current_user.stories.find(params[:id])
    @story.update(story_params)

    if @story.save
      render :json => @story
    else
      render :json => { :errors => @story.errors.full_messages }, :status => 400
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :total_pieces, :max_sentences)
  end
end

