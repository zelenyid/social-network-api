FactoryBot.define do
  factory :post do
    association :user, factory: :user
    content { Faker::Quote.famous_last_words }
  end
end
