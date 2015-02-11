class PieceValidator::PostedLast < ActiveModel::Validator

  def validate(piece)
    if !piece.persisted? && user_posted_last_piece?(piece)
      piece.errors[:piece] << "You posted the last piece of this story!"
    end
  end

  private

  def user_posted_last_piece?(piece)
    if piece.story && !piece.story.pieces.empty?
      # FIXME Ugh...
      piece.story.pieces.last.user == piece.user
    else
      false
    end
  end
end
