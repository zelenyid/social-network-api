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
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, lambda { |sender_id, recipient_id|
    where(
      '(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)', # rubocop:disable Layout/LineLength
      sender_id, recipient_id, recipient_id, sender_id
    )
  }
end
