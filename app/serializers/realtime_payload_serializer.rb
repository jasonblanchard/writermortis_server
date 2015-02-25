class RealtimePayloadSerializer < ActiveModel::Serializer
  attributes :resource, :action, :data

  def data
    serializer_class = "#{resource.capitalize}Serializer".constantize
    serializer_class.new(object.data)
  end
end
