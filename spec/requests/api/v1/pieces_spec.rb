describe 'Pieces API' do

  describe 'create' do
    
    let(:story) { FactoryGirl.create(:story) }
    let(:user) { FactoryGirl.create(:user) }

    context 'when the user is authorized to create a piece' do
 
      before do
        post "/api/v1/pieces", :piece => {:text => "Once upon a time", :story_id => story.id}, :user_email => user.email, :user_token => user.authentication_token
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
        post "/api/v1/pieces", :piece => {:text => "" }, :user_email => user.email, :user_token => user.authentication_token
      end

      it 'returns a 400 status code' do
        expect(response.status).to eq 400
      end

      it 'returns an errors object' do
        expect(json['errors']).to be_a Array
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
end
