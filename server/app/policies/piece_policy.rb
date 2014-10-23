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
end
