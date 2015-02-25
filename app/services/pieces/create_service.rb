class Pieces::CreateService

  def initialize(piece)
    @piece = piece
  end

  def save
    if piece = @piece.save

      # TODO Refactor this into a realtime publisher service
      RedisService.new.publish 'rt-change', @piece.to_realtime_payload(:action => :create)
    end

    piece
  end
end
