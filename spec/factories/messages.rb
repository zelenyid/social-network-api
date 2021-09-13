# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  body            :text
#  conversation_id :bigint
#  user_id         :bigint
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
FactoryBot.define do
  factory :message do
    association :conversation, factory: :conversation
    association :user, factory: :user
    body { Faker::Quote.famous_last_words }
    read { true }

    created_at { '2016-11-11 13:30:31 UTC' }
  end
end
