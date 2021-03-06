class Api::V1::StoriesController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :update, :destroy]
  before_action :get_story, :only => [:show, :update, :destroy]

  def index
    @stories = Story.sorted.includes(:user)
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
      render :json => { :errors => @story.errors }, :status => 422
    end
  end

  def update
    @story.update(story_params)

    authorize @story

    if @story.save
      render :json => @story
    else
      render :json => { :errors => @story.errors }, :status => 422
    end
  end

  def destroy
    authorize @story
    @story.destroy

    render :json => @story,  :status => 204
  end

  private

  def story_params
    params.require(:story).permit(:title, :total_pieces, :max_sentences)
  end

  def get_story
    @story = Story.find(params[:id])
  end

end

