require 'rails_helper'

RSpec.describe Piece, :type => :model do
  it { should belong_to :user }
  it { should belong_to :story }
  it { should validate_presence_of :story }
  it { should validate_presence_of :user }
  it { should validate_presence_of :text }

  describe 'validations' do
    it 'does not validate if there are too many sentences' do
      skip "Not implemented yet"
    end

    context 'when the same user posted the last piece' do
      it 'does not validate' do
        skip
      end
    end

    context 'when the story has all the pieces' do
      it 'does not validate' do
        skip
      end
    end

    context 'when the story has too many sentences' do
      it 'does not validate' do
        skip
      end
    end
  end
end
