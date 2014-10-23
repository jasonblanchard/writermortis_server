describe PieceValidator do

  describe "#validate" do
    let(:story) { FactoryGirl.create(:story, :max_sentences => 3) }
    let(:user) { FactoryGirl.create(:user) }

    context "When the piece excedes its story's max sentences" do
      it "returns errors" do
        skip "Not implemented yet"
      end
    end

    context "When the user posted the last story piece" do
      let!(:last_piece) { FactoryGirl.create(:piece, :user => user, :story => story) }
      let!(:new_piece) { FactoryGirl.build(:piece, :user => user, :story => story) }

      it "returns errors" do
        PieceValidator.new.validate(new_piece)
        expect(new_piece.errors.messages[:piece]).to include "You posted the last piece of this story!"
      end
    end

     context "When the story already has all its pieces" do
       it "returns errors" do
        skip "Not implemented yet"
       end
     end
  end
end
