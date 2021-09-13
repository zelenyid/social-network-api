FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    content { Faker::Quote.famous_last_words }
  end
end
