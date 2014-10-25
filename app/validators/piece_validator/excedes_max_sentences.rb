class PieceValidator::ExcedesMaxSentences < ActiveModel::Validator
  
  def validate(piece)
    if has_too_many_sentences?(piece)
      piece.errors[:piece] << "This piece has too many sentences."
    end
  end

  private

  def has_too_many_sentences?(piece)
    if story = piece.story
      SentenceCounter.new(piece.text).count > story.max_sentences
    else
      false
    end
  end

end

