describe PieceValidator::PostedLast do

  describe "#validate" do
    let(:story) { FactoryGirl.create(:story, :max_sentences => 3, :total_pieces => 2) }
    let(:user) { FactoryGirl.create(:user) }

    context "When the user posted the last story piece" do
      let(:new_piece) { FactoryGirl.build(:piece, :user => user, :story => story) }

      before do
        story.pieces << FactoryGirl.create(:piece, :user => user)
      end

      it "returns errors" do
        PieceValidator::PostedLast.new.validate(new_piece)
        expect(new_piece.errors.messages[:piece]).to include "You posted the last piece of this story!"
      end
    end

    context "When updating an existing piece" do
      let(:user2) { FactoryGirl.create(:user) }

      before do
        story.pieces << FactoryGirl.create(:piece, :user => user)
        story.pieces << FactoryGirl.create(:piece, :user => user2)
      end

      it "does not return errors" do

        existing_piece = story.pieces.last
        expect(existing_piece.valid?).to eq true
      end
    end
  end
end
