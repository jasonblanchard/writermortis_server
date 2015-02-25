class Pieces::CreateService

  def initialize(piece)
    @piece = piece
  end

  def save
    if piece = @piece.save
      # TODO How to test this is publishing a payload?
      RealtimePublisher.new(@piece).publish(:create)
    end
    piece
  end
end
