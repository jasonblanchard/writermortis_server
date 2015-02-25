class RealtimePublisher
  
  CHANNEL = 'rt-change'

  def initialize(resource)
    @resource = resource
  end

  def publish(action)
    RedisService.new.publish CHANNEL, @resource.to_realtime_payload(:action => action)
  end
end
