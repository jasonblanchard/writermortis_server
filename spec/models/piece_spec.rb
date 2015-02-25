require 'rails_helper'

RSpec.describe Piece, :type => :model do
  it { should belong_to :user }
  it { should belong_to :story }
  it { should validate_presence_of :story }
  it { should validate_presence_of :user }
  it { should validate_presence_of :text }

  let(:story) { FactoryGirl.create(:story, :max_sentences => 2, :total_pieces => 2) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:piece) { FactoryGirl.create(:piece, :user => user) }

  describe 'validations' do

    context 'when the same user posted the last piece' do
      let!(:piece1) { FactoryGirl.build(:piece, :user => user) }
      let(:new_piece) { FactoryGirl.build(:piece, :story => story, :user => user) }

      before do
        story.pieces << piece1
      end

      it 'does not validate' do
        expect(new_piece.valid?).to eq false
      end
    end

    context 'when the story has all the pieces' do
      let(:new_piece) { FactoryGirl.build(:piece, :story => story) }
      
      before do
        2.times do
          piece = FactoryGirl.build(:piece)
          story.pieces << piece
        end
      end
        
      it 'does not validate' do
        expect(new_piece.valid?).to eq false
      end
    end

    context 'when the story has too many sentences' do
      let(:piece) { FactoryGirl.build(:piece, :text => "I'm a sentence. I'm another sentence. I'm one too long") }
      it 'does not validate' do
        expect(piece.valid?).to eq false
      end
    end
  end

  context "When sending realtime updates" do
    it "Can create an update payload" do
      payload = piece.to_realtime_payload(:action => :create)
      expect(payload).to eq "{\"resource\":\"piece\",\"action\":\"create\",\"data\":{\"piece\":{\"id\":#{piece.id},\"story_id\":1,\"user_id\":1,\"text\":\"Once upon a time...\",\"created_at\":\"#{piece.created_at}\",\"updated_at\":\"#{piece.updated_at}\"}}}"
    end
  end
end
