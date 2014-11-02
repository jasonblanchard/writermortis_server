class Api::V1::PiecesController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def create
    @piece = current_user.pieces.new(piece_params)

    authorize @piece

    if @piece.save
      render :json => @piece
    else
      render :json => {:errors => @piece.errors.full_messages}, :status => 400
    end
    
  end

  private

  def piece_params
    params.require(:piece).permit(:text, :created_at, :updated_at, :story_id)
  end

end
