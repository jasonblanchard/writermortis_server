class PieceValidator < ActiveModel::Validator

  def validate(record)
    if user_posted_last_piece(record)
      record.errors[:piece] << "You posted the last piece of this story!"
    end
  end

  private

  def user_posted_last_piece(piece)
    if piece.story && !piece.story.pieces.empty?
      # FIXME Ugh...
      piece.story.pieces.last.user == piece.user
    end
  end

end
