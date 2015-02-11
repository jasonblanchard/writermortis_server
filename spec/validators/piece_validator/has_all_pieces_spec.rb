describe PieceValidator::HasAllPieces do

  describe '#validate' do
    context "When the story already has all its pieces" do

      let(:story) { FactoryGirl.create(:story, :total_pieces => 2) }
      let(:user) { FactoryGirl.create(:user) }
      let(:new_piece) { FactoryGirl.build(:piece, :user => user, :story => story) }

      before do
        2.times do
          story.pieces << FactoryGirl.create(:piece)
        end
      end

      it "returns errors" do
        PieceValidator::HasAllPieces.new.validate(new_piece)
        expect(new_piece.errors.messages[:piece]).to include "The story is already complete!"
      end

      context "editing an existing piece" do
        it "does not return errors" do
          existing_piece = story.pieces.last
          expect(existing_piece.valid?).to eq true
        end
      end
    end
  end

end
