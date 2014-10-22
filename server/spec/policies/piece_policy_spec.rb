describe PiecePolicy do
  
  let(:piece) { FactoryGirl.build(:piece) }
  let(:user) { FactoryGirl.build(:user) }

  permissions :create? do
    it "denies access if there is no user" do
      expect(PiecePolicy).to_not permit(nil, piece)
    end

    it "permits access if there is a user" do
      expect(PiecePolicy).to permit(user, piece)
    end
  end

end
