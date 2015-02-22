class RedisService
  def initialize
    @redis = $redis
  end

  def publish(channel, message)
    if @redis.connected?
      @redis.publish channel, message
    else
      Rails.logger.info "Redis not connected"
    end
  end
end
