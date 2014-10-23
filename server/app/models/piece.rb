class Piece < ActiveRecord::Base
  
  validates_presence_of :user, :story, :text

  belongs_to :story
  belongs_to :user

  # validates :does_not_excede_max_sentences
  # validates :user_did_not_post_last_piece
  # validates :story already has max pieces
  validates_with PieceValidator::PostedLast
  validates_with PieceValidator::HasAllPieces
end
