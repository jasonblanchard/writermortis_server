describe 'Stories API' do
  
  describe 'index' do

    let!(:story1) { FactoryGirl.create(:story, :created_at => Time.now - 2.hours, :title => 'First story') }
    let!(:story2) { FactoryGirl.create(:story, :created_at => Time.now - 1.hour) }
    let!(:story3) { FactoryGirl.create(:story, :created_at => Time.now - 1.minute, :title => 'most recent') }

    it 'returns a list of stories' do
      get '/api/v1/stories'

      expect(json['stories'].length).to eq 3
      expect(json['stories'].first['title']).to eq 'most recent'
    end
  end

  describe 'show' do
    let(:story) { FactoryGirl.create(:story) }

    before do
      get "/api/v1/stories/#{story.id}"
    end

    it 'returns a story' do
      expect(json['story']['title']).to eq story.title
    end

    context 'when the story has pieces' do

      let!(:piece) { FactoryGirl.create(:piece, :story => story) }

      it 'sideloads the pieces' do
        get "/api/v1/stories/#{story.id}"

        expect(json['pieces'].first['text']).to eq piece.text
      end
    end
  end

  describe 'create' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      post '/api/v1/stories', {:story => {:title => "This is my story" }}.merge(token_auth_for(user))
    end

    it 'returns 201 status code' do
      expect(response.status).to eq 201
    end

    it 'creates a new story and returns the story object' do
      story = Story.last
      expect(story.title).to eq "This is my story"
      expect(json['story']['title']).to eq "This is my story"
    end

    context 'when there is a validation error' do
      before do
        post '/api/v1/stories', {:story => {:title => ''}}.merge(token_auth_for(user))
      end
      
      it 'has an error status code' do
        expect(response.status).to eq 422
      end

      it 'returns an errors object' do
        expect(json['errors']).to be_a Hash
      end
    end
  end

  describe 'update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:story) { FactoryGirl.create(:story, :user => user) }

    context 'when the user is not autorized to edit the story' do

      before do
        patch "/api/v1/stories/#{story.id}", {:story => {:title => 'Updated title'}}.merge(token_auth_for(user2))
      end

      let(:user2) { FactoryGirl.create(:user) }

      it 'returns 401 status code' do
        expect(response.status).to eq 401
      end

      it 'returns 401 when the user is not authenticated' do
        expect(response.status).to eq 401
      end
    end

    context 'when the user is authorized to edit the story' do

      before do
        patch "/api/v1/stories/#{story.id}", {:story => {:title => 'Updated title'}}.merge(token_auth_for(user))
      end

      it 'returns a 200 status code' do
        expect(response.status).to eq 200
      end

      it 'updates the story and returns the story json' do
        expect(story.reload.title).to eq "Updated title"
        expect(json['story']['title']).to eq 'Updated title'
      end

      context 'when there is a validation error' do
        before do
          patch "/api/v1/stories/#{story.id}", {:story => {:title => ''}}.merge(token_auth_for(user))
        end

        it 'returns an error status code' do
          expect(response.status).to eq 422
        end

        it 'returns an errors object' do
          expect(json['errors']).to be_a Hash
        end
      end
    end
  end

  describe 'delete' do
    let(:user) { FactoryGirl.create(:user) }
    let(:story) { FactoryGirl.create(:story, :user => user) }

    context 'when the user is authorized to delete the story' do
      before do
        delete "/api/v1/stories/#{story.id}", token_auth_for(user)
      end

      it 'returns a 204 status code' do
        expect(response.status).to eq 204
      end
      it 'deletes the story' do
        expect(Story.all.count).to eq 0
      end
    end

    context 'when the user is not authorized to delete the story' do
      let(:user2) { FactoryGirl.create(:user) }

      it 'returns 401 status code' do
        delete "/api/v1/stories/#{story.id}", token_auth_for(user2)

        expect(response.status).to eq 401
      end

      it 'returns 401 when the user is not authenticated' do
        delete "/api/v1/stories/#{story.id}"
        expect(response.status).to eq 401
      end
    end
  end
end
