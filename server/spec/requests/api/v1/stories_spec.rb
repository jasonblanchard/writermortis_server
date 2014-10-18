describe 'Stories API' do
  
  describe 'index' do

    let!(:story1) { FactoryGirl.create(:story, :created_at => Time.now - 1.minute, :title => 'First story') }
    let!(:story2) { FactoryGirl.create(:story, :created_at => Time.now - 1.hour) }
    let!(:story3) { FactoryGirl.create(:story, :created_at => Time.now - 2.hours) }

    it 'returns a list of stories' do
      get '/api/v1/stories'

      expect(json['stories'].length).to eq 3
      expect(json['stories'].first['title']).to eq 'First story'
    end
  end

end
