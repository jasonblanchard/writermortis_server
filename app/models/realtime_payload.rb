class RealtimePayload
  include ActiveModel::Serialization
  attr_accessor :resource, :action, :data

  def initialize(resource, action, data)
    @resource = resource
    @action = action
    @data = data
  end
end
