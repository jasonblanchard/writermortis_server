class RealtimePublisher
  
  CHANNEL = 'rt-change'

  def initialize(resource, message_bus=RedisService.new)
    @resource = resource
    @message_bus = message_bus
  end

  def publish(action)
    @message_bus.publish CHANNEL, @resource.to_realtime_payload(:action => action)
  end
end
