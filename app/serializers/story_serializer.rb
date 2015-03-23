class StorySerializer < ActiveModel::Serializer
  embed :ids, :include => true
  has_many :pieces
  has_one :user

  attributes :id, :title, :total_pieces, :max_sentences, :created_at, :updated_at

  def pieces
    object.pieces.includes(:user)
  end
end
