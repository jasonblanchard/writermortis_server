require 'rails_helper'

RSpec.describe Story, :type => :model do
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(99) }
  it { should validate_numericality_of(:total_pieces).is_greater_than_or_equal_to(2) }
  it { should validate_numericality_of(:total_pieces).is_less_than(99) }
  it { should validate_numericality_of(:max_sentences).is_less_than(15) }
end
