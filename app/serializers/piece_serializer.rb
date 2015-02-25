class PieceSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  has_one :user

  attributes :id, :text, :created_at, :updated_at, :story_id
end
