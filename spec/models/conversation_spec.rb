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
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:sender_id).of_type(:integer) }
    it { is_expected.to have_db_column(:recipient_id).of_type(:integer) }
  end

  describe 'Model relations' do
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }
  end

  describe 'Model scope' do
    let(:sender) { create(:confirmed_user) }
    let(:recipient) { create(:confirmed_user) }
    let(:conversation) { create(:conversation, sender: sender, recipient: recipient) }

    it { described_class.between(sender.id, recipient.id).should match_array(conversation) }
    it { described_class.between(recipient.id, sender.id).should match_array(conversation) }
  end
end
