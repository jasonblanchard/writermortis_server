describe "Registrations API" do

  let(:user) { FactoryGirl.create(:user) }

  describe '#create' do
    describe 'when there is a validation error' do
      it 'returns the errors and a status code' do
        post '/api/v1/registrations', {:registration => {:email => user.email, :username => "baduser", :password => 'testpass', :password_confirmation => 'testpass'}}

        expect(response.status).to eq 400
        expect(json['errors']).to include 'Email has already been taken'
      end
    end

    describe "when the password and password validation don't match" do
      it 'returns the errors and a status code' do
        post '/api/v1/registrations', {:registration => {:email => 'newuser@example.com', :username => "newuser", :password => 'testpass', :password_confirmation => 'testpazzzzzz'}}

        expect(response.status).to eq 400
        expect(json['errors']).to include "Password confirmation doesn't match Password"
      end
    end

    describe 'for a valid request' do
      it 'returns the user object and a 200 status code' do
        post '/api/v1/registrations', {:registration => {:email => 'newuser@example.com', :username => "newuser", :password => 'testpass', :password_confirmation => 'testpass'}}

        expect(response.status).to eq 200
        expect(json['user']['email']).to eq 'newuser@example.com'
        expect(json['user']['username']).to eq 'newuser'
      end

      it 'creates the user' do
        post '/api/v1/registrations', {:registration => {:email => 'newuser@example.com', :username => "newuser", :password => 'testpass', :password_confirmation => 'testpass'}}

        expect(User.last.email).to eq 'newuser@example.com'
      end
    end
  end
end
