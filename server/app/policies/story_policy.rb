class StoryPolicy
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  def update?
    is_owner?(@user, @story)
  end

  def destroy?
    is_owner?(@user, @story)
  end
  
  private

  def is_owner?(user, resource)
    user.id == resource.user_id
  end

end
