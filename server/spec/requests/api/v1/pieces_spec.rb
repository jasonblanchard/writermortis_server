describe 'Pieces API' do

  describe 'create' do
    
    let(:story) { FactoryGirl.create(:story) }
    let(:user) { FactoryGirl.create(:user) }

    context 'when the user is authorized to create a piece' do
 
      before do
        post "/api/v1/stories/#{story.id}/pieces", :piece => {:body => "Once upon a time" }
      end

      it 'creates the piece for the story' do
        piece = story.pieces.last
        expect(piece.story).to eq story
        expect(piece.body).to eq "Once upon a time"
        expect(piece.user).to eq user
      end

      it 'returns the new piece as json' do
        skip
      end

      context 'when there is a validation error' do
        it 'returns a 400 status code' do
          skip
        end

        it 'returns an errors object' do
          skip
        end
      end
    end

    context 'when the user is not authorized to create the piece' do
      it 'returns 401 status code' do
        skip
      end
    end

    context 'when the user is not authenticated' do
      it 'returns 401 status code' do
        skip
      end
    end
  end
end
