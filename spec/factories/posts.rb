FactoryBot.define do
  factory :post do
    content { Faker::Hipster.sentences(sentence_count=3) }
    user_id nil
  end
end