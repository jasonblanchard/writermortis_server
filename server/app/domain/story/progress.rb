class Story
  class Progress
    def initialize(story)
      @story = story
    end

    def complete?
      @story.pieces.length == @story.total_pieces
    end
  end
end
