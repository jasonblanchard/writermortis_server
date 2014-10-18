class Piece < ActiveRecord::Base
  
  validates_presence_of :user, :story, :text

  belongs_to :story
  belongs_to :user

  # validates :does_not_excede_max_sentences
  # TODO Where does this logic belong?
end
