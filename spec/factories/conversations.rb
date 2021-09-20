# == Schema Information
#
# Table name: conversations
#
#  id           :bigint           not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_conversations_on_sender_id_and_recipient_id  (sender_id,recipient_id) UNIQUE
#
FactoryBot.define do
  factory :conversation do
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
