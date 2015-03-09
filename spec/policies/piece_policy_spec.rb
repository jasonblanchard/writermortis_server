describe PiecePolicy do
  
  let(:user) { FactoryGirl.build(:user) }
  let(:piece) { FactoryGirl.build(:piece, :user => user) }

  permissions :create? do
    it "denies access if there is no user" do
      expect(PiecePolicy).to_not permit(nil, piece)
    end

    it "permits access if there is a user" do
      expect(PiecePolicy).to permit(user, piece)
    end
  end

  permissions :destroy? do
    it "denies access if there is no user" do
      expect(PiecePolicy).to_not permit(nil, piece)
    end
    
    it "allows access if the user is the owner" do
      expect(PiecePolicy).to permit(user, piece)
    end
  end

end
