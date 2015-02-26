class MockMessageBus
  class Queue

    attr_reader :messages

    def initialize
      @messages = []
    end

    def publish(channel, data)
      @messages << {:channel => channel, :data => data}
    end
  end
end
