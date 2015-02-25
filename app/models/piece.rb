class Piece < ActiveRecord::Base

  include RealtimeUpdateable
  
  validates_presence_of :user, :story, :text

  belongs_to :story
  belongs_to :user

  validates_with PieceValidator::PostedLast
  validates_with PieceValidator::HasAllPieces
  validates_with PieceValidator::ExcedesMaxSentences
end
