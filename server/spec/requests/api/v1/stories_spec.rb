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

end
