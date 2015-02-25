module RealtimeUpdateable
  extend ActiveSupport::Concern

  def to_realtime_payload(options)
    msg = RealtimePayload.new(self.class.to_s.downcase, options[:action], self)
    RealtimePayloadSerializer.new(msg).to_json
  end
end
