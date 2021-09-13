# == Schema Information
#
# Table name: friendships
#
#  id               :bigint           not null, primary key
#  user_sender_id   :integer          not null
#  user_receiver_id :integer          not null
#  status           :integer          default("sended")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_sender_id_and_user_receiver_id    (user_sender_id,user_receiver_id) UNIQUE
#  index_requests_on_interchangable_receiver_id_and_sender_id
#          (LEAST(user_sender_id, user_receiver_id), GREATEST(user_sender_id, user_receiver_id)) UNIQUE
#  index_requests_on_interchangable_sender_id_and_receiver_id
#          (GREATEST(user_sender_id, user_receiver_id), LEAST(user_sender_id, user_receiver_id)) UNIQUE
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:user_sender_id).of_type(:integer) }
    it { is_expected.to have_db_column(:user_receiver_id).of_type(:integer) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:user_sender).class_name('User') }
    it { is_expected.to belong_to(:user_receiver).class_name('User') }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'Model scope' do
    let(:sended) { create_list(:friendship, 5, status: :sended) }
    let(:accepted) { create_list(:friendship, 5) }

    it { described_class.sended.should match_array(sended) }
    it { described_class.accepted.should match_array(accepted) }
  end
end
