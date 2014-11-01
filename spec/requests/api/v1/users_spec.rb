describe "Users API" do
  describe 'show' do

    let(:user) { FactoryGirl.create(:user) }
    
    it 'returns a serialized user' do
      get "/api/v1/users/#{user.id}"

      expect(json['user']['email']).to eq user.email
    end
  end
end
