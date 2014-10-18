class Story < ActiveRecord::Base
  validates :title, :presence => true, :length => {:maximum => 99}
  validates :total_pieces, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 2, :less_than => 99 }
  validates :max_sentences, :presence => true, :numericality => { :less_than => 15 }
  validates_presence_of :user

  has_many :pieces
  belongs_to :user

  scope :sorted, -> { order('created_at DESC') }

end
