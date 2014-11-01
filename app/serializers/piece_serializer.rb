class PieceSerializer < ActiveModel::Serializer
  embed :ids, :include => true
  has_one :user

  attributes :id, :text
end
