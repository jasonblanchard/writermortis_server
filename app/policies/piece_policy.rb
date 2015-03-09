class PiecePolicy
  attr_reader :user, :piece

  def initialize(user, story)
    @user = user
    @story = story
  end

  def create?
    # TODO Do we need this?
    !!@user
  end

  def destroy?
    is_owner?(@user, @story)
  end

  private

  def is_owner?(user, resource)
    if user
      user.id == resource.user_id
    end
  end
end
