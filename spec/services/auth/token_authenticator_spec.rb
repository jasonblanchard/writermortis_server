describe Auth::TokenAuthenticator do
  
  let(:user) { FactoryGirl.create(:user, :authentication_token => '1234') }
  let(:authenticator) { Auth::TokenAuthenticator.new(user) }
  
  it "can be created with a user" do
    expect(authenticator).to be_an Auth::TokenAuthenticator
  end

  describe "#valid?" do
    it "returns true for a valid user token" do
      token = authenticator.regenerate!
      output = authenticator.valid?(token)
      expect(output).to eq true
    end
  end

  describe "#regenerate!" do
    it "creates a new token and returns it" do
      old_token = user.authentication_token
      new_token = authenticator.regenerate!
      expect(new_token).to be_a String
      expect(new_token).to match(/[a-zA-Z1-9]/)
      expect(new_token).to_not eq old_token
    end
  end
end
