class RedisService
  def initialize
    @redis = $redis
  end

  def publish(channel, message)
    begin
      @redis.publish channel, message
    rescue
      Rails.logger.info "Redis not connected"
    end
  end
end
