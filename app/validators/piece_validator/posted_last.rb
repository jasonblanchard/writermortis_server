class PieceValidator::PostedLast < ActiveModel::Validator

  def validate(piece)
    if !piece.persisted? && user_posted_last_piece?(piece)
      piece.errors[:piece] << "You posted the last piece of this story!"
    end
  end

  private

  def user_posted_last_piece?(piece)
    
    if piece.story_id
      story = Story.where(:id => piece.story_id).includes(:pieces).first
      pieces = story.pieces
    end

    if story && !pieces.empty?
      story.pieces.last.user_id == piece.user_id
    else
      false
    end
  end
end
