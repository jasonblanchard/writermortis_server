describe "Users API" do
  let(:user) { FactoryGirl.create(:user) }

  describe 'show' do
    it 'returns a serialized user' do
      get "/api/v1/users/#{user.id}"

      expect(json['user']['email']).to eq user.email
    end
  end

end
