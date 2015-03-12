describe Pieces::DestroyService do
  describe '#desroy' do
    let!(:piece) { FactoryGirl.create(:piece) }
    it "destroys the piece" do
      service = Pieces::DestroyService.new(piece)
      expect { service.destroy}.to change{Piece.all.count}.from(1).to(0)
    end
    
    it "calls realtime publisher" do
      expect_any_instance_of(RealtimePublisher).to receive(:publish).with(:destroy)
      service = Pieces::DestroyService.new(piece)
      service.destroy
    end
  end
end
