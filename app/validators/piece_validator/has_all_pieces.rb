class PieceValidator::HasAllPieces < ActiveModel::Validator

  def validate(piece)
    if !piece.persisted? && story_is_already_complete?(piece)
      piece.errors[:piece] << "The story is already complete!"
    end
  end

  private

  def story_is_already_complete?(piece)
    Stories::Progress.new(piece.story).complete?
  end

end
