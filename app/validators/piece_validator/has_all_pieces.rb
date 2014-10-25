class PieceValidator::HasAllPieces < ActiveModel::Validator

  def validate(piece)
    if story_is_already_complete?(piece)
      piece.errors[:piece] << "The story is already complete!"
    end
  end

  private

  def story_is_already_complete?(piece)
    Story::Progress.new(piece.story).complete?
  end

end
