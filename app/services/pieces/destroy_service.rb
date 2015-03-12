class Pieces::DestroyService
  def initialize(piece)
    @piece = piece
  end

  def destroy
    piece = @piece.destroy
    RealtimePublisher.new(@piece).publish(:destroy)
    piece
  end
end
