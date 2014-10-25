describe Story::Progress do

  describe '#complete?' do
    let(:story) { FactoryGirl.build(:story, :total_pieces => 2) }

    describe 'when the story does not have all its pieces' do
      it 'returns false' do
        expect(Story::Progress.new(story).complete?).to eq false
      end
    end

    describe 'when the story has all its pieces' do

      before do
        2.times do
          story.pieces << FactoryGirl.create(:piece)
        end
      end

      it 'returns true' do
        expect(Story::Progress.new(story).complete?).to eq true
      end
    end
  end
end
