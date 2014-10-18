FactoryGirl.define do
  factory :story do
    user
    title "MyString"
    total_pieces 3
    max_sentences 1
  end
end
