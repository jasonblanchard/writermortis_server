class StorySerializer < ActiveModel::Serializer
  embed :ids, :include => true
  has_many :pieces
  has_one :user

  attributes :id, :title, :total_pieces, :max_sentences

  def pieces
    object.pieces.includes(:user)
  end
end
