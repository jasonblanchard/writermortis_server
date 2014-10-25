describe SentenceCounter do
  
  let(:string) { 'This is the first sentence about Mr. and Mrs. B. "They are great!" she said. Does Dr. S like to operate? I think so...' }
  
  it "Returns the number of senteneces from a string" do
    expect(SentenceCounter.new(string).count).to eq 4
  end
end
