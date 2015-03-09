require 'rails_helper'

RSpec.describe User, :type => :model do
  
  let!(:user) { FactoryGirl.create(:user, :username => 'username') }

  it { should have_many :stories }
  it { should have_many :pieces }

  describe 'validations' do
    describe 'username' do
      let(:user2) { FactoryGirl.build(:user, :username => 'username') }
      it "must be unique" do
        expect(user2.valid?).to eq false
        expect(user2.errors.messages.keys).to include :username
        expect(user2.errors.messages.values.flatten).to include "has already been taken"
      end
      it 'cannot include special characters' do
        user2.username = '!@#$'
        expect(user2.valid?).to eq false
        expect(user2.errors.messages.keys).to include :username
        expect(user2.errors.messages.values.flatten).to include "is invalid"
      end
    end
  end
end
