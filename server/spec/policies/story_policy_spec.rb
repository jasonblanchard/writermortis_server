describe StoryPolicy do
  let(:user) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story, :user => user) }

  permissions :update? do
    it "denies access if the user is not the owner" do
      expect(StoryPolicy).to_not permit(FactoryGirl.create(:user), story)
    end

    it "grants access if the user is the owner" do
      expect(StoryPolicy).to permit(user, story)
    end
  end

  permissions :destroy? do
    it "denies access if the user is not the owner" do
      expect(StoryPolicy).to_not permit(FactoryGirl.create(:user), story)
    end

    it "grants access if the user is the owner" do
      expect(StoryPolicy).to permit(user, story)
    end
  end

end
