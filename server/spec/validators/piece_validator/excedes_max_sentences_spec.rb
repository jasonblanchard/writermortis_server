describe PieceValidator::ExcedesMaxSentences do

  describe '#validate' do
    context "When the piece excedes its story's max sentences" do
      
      let(:story) { FactoryGirl.create(:story, :max_sentences => 3) }
      let(:piece) { FactoryGirl.build(:piece, :story => story, :text => "This is the first sentence about Mr. and Mrs. B. \"They are great!\" she said. Does Dr. S like to operate? I think so...") }

      it "returns errors" do
        PieceValidator::ExcedesMaxSentences.new.validate(piece)
        expect(piece.errors.messages[:piece]).to include "This piece has too many sentences."
      end
    end
  end

end
