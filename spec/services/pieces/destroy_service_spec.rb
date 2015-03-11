describe Pieces::DestroyService do
  describe '#desroy' do
    let!(:piece) { FactoryGirl.create(:piece) }
    it "destroys the piece" do
      service = Pieces::DestroyService.new(piece)
      expect { service.destroy}.to change{Piece.all.count}.from(1).to(0)
    end
    
    it "calls realtime publisher" do
      skip
    end
  end
end
