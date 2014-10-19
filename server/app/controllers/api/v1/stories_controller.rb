class Api::V1::StoriesController < ApplicationController
  
  before_action :get_story, :only => [:show, :update, :destroy]

  def index
    @stories = Story.sorted
    render :json => @stories
  end

  def show
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
    @story.update(story_params)

    if @story.save
      render :json => @story
    else
      render :json => { :errors => @story.errors.full_messages }, :status => 400
    end
  end

  def destroy
    @story.destroy

    render :json => { :deleted => true }
  end

  private

  def story_params
    params.require(:story).permit(:title, :total_pieces, :max_sentences)
  end

  def get_story
    @story = Story.find(params[:id])
  end
end

