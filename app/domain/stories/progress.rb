class Stories::Progress
  def initialize(story)
    @story = story
  end

  def complete?
    if @story
      @story.pieces.length == @story.total_pieces
    else
      false
    end
  end
end
