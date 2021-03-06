describe 'Pieces API' do
    
  let(:story) { FactoryGirl.create(:story) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'create' do

    context 'when the user is authorized to create a piece' do
 
      before do
        post "/api/v1/pieces", {:piece => {:text => "Once upon a time", :story_id => story.id}}.merge(token_auth_for(user))
      end

      it 'creates the piece for the story' do
        expect(response.status).to eq 200
        piece = story.pieces.last
        expect(piece.story).to eq story
        expect(piece.text).to eq "Once upon a time"
        expect(piece.user).to eq user
      end

      it 'returns the new piece as json' do
        expect(json['piece']['text']).to eq "Once upon a time"
      end
    end

    context 'when there is a validation error' do
      before do
        post "/api/v1/pieces", {:piece => {:text => "" }}.merge(token_auth_for(user))
      end

      it 'returns a 401 status code' do
        expect(response.status).to eq 422
      end

      it 'returns an errors object' do
        expect(json['errors']).to be_a Hash
      end
    end


    context 'when the user is not authenticated' do
      before do
        post "/api/v1/pieces", :piece => {:text => "" }
      end

      it 'returns 401 status code' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'destroy' do
    let!(:piece) { FactoryGirl.create(:piece, :user => user, :story => story) }

    context 'when the user is not authenticated' do
      before do
        delete "/api/v1/pieces/#{piece.id}"
      end

      it 'returns 401 status code' do
        expect(response.status).to eq 401
      end
    end

    context 'when the user is authenticated to destroy piece' do
      before do
        delete "/api/v1/pieces/#{piece.id}", {:id => piece.id}.merge(token_auth_for(user))
      end

      it 'deletes the piece' do
        expect(response.status).to eq 204
        expect(story.pieces.count).to eq 0
      end
    end
  end
end
