class Pieces::DestroyService
  def initialize(piece)
    @piece = piece
  end

  def destroy
    @piece.destroy
  end
end
