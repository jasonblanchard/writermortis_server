class StorySerializer < ActiveModel::Serializer
  embed :ids, :include => true
  has_many :pieces

  attributes :id, :title, :total_pieces, :max_sentences
end
