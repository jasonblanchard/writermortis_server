require 'rails_helper'

RSpec.describe Piece, :type => :model do
  it { should belong_to :user }
  it { should belong_to :story }
  it { should validate_presence_of :story }
  it { should validate_presence_of :user }
  it { should validate_presence_of :text }

  describe 'validates :does_not_excede_max_sentences' do
    it 'does not validate if there are too many sentences' do
      skip "Not implemented yet"
    end
  end
end
