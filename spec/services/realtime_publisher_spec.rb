describe RealtimePublisher do
  
  let(:piece) { FactoryGirl.create(:piece) }
  let(:message_bus) { MockMessageBus::Queue.new }
  let(:realtime_publisher) { RealtimePublisher.new(piece, message_bus) }
  
  it 'pushes data into the queue' do
    realtime_publisher.publish(:create)
    message = message_bus.messages.last
    expect(message[:channel]).to include "rt-change"
    parsed_data = JSON.parse(message[:data])['realtime_payload']
    expect(parsed_data['resource']).to eq "piece"
    expect(parsed_data['action']).to eq "create"
    expect(parsed_data['data']).to be_a Hash
  end
end
