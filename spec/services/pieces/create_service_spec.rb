describe Pieces::CreateService do
  describe "#save" do
    let(:piece) { FactoryGirl.build(:piece) }
    it "saves a piece" do
      service = Pieces::CreateService.new(piece)
      expect{service.save}.to change{Piece.all.count}.from(0).to(1)
    end

    it 'calls realtime publisher' do
      expect_any_instance_of(RealtimePublisher).to receive(:publish).with(:create)
      service = Pieces::CreateService.new(piece)
      service.save
    end
  end
end
