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

    it 'returns a story' do

      get "/api/v1/stories/#{story.id}"

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

    it 'returns 201 status code' do
      post '/api/v1/stories', :user_email => user.email, :user_token => user.authentication_token, :story => {:title => "This is my story" }

      expect(response.status).to eq 201
    end

    it 'creates a new story and returns the story object' do
      post '/api/v1/stories', :user_email => user.email, :user_token => user.authentication_token, :story => {:title => "This is my story" }

      story = Story.last
      expect(story.title).to eq "This is my story"
      expect(json['story']['title']).to eq "This is my story"
    end

    context 'when there is a validation error' do
      it 'has a 400 status code' do
        post '/api/v1/stories', :user_email => user.email, :user_token => user.authentication_token, :story => {:title => ''}

        expect(response.status).to eq 400
      end

      it 'returns an errors object' do
        post '/api/v1/stories', :user_email => user.email, :user_token => user.authentication_token, :story => {:title => ''}

        expect(json['errors']).to be_a Array
      end
    end
  end

end
