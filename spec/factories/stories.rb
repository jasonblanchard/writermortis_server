FactoryGirl.define do
  factory :story do
    user
    title "My Great Story"
    total_pieces 3
    max_sentences 1
  end
end
