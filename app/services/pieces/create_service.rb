class Pieces::CreateService

  def initialize(piece)
    @piece = piece
  end

  def save
    if piece = @piece.save
      msg = { :resource => 'piece', :action => 'create', :data => @piece }
      $redis.publish 'rt-change', msg.to_json
    end

    piece
  end
end
