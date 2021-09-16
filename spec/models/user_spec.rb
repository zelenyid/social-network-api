# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  surname                :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :jsonb
#  admin                  :boolean          default(FALSE)
#  user_role              :boolean          default(TRUE)
#  banned                 :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:surname).of_type(:string) }
    it { is_expected.to have_db_column(:avatar).of_type(:jsonb) }
  end

  describe 'Table indexes' do
    it { is_expected.to have_db_index(:email) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:surname) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'Model relations' do
    subject(:user) { described_class.new }

    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }

    it 'has many sended_invitations' do
      expect(user).to have_many(:sended_invitations).class_name('Friendship').with_foreign_key('user_sender_id')
                                                    .inverse_of(:user_sender).dependent(:destroy)
    end

    it 'has many received_invitations' do
      expect(user).to have_many(:received_invitations).class_name('Friendship').with_foreign_key('user_receiver_id')
                                                      .inverse_of(:user_receiver).dependent(:destroy)
    end
  end

  describe '#friends & #friend_with?' do
    let(:user) { create(:user) }
    let(:friends) { create_list(:user, 5) }

    before do
      friends.each do |friend|
        create(:friendship, user_sender: user, user_receiver: friend)
      end
    end

    it { friends.should match_array(user.friends) }
    it { user.friend_with?(friends.first).should eq true }
    it { friends.first.friend_with?(friends.second).should eq false }
  end

  describe '#pending_invitations' do
    let(:user) { create(:user) }
    let(:friends) { create_list(:user, 5) }

    before do
      friends.each do |friend|
        create(:friendship, user_sender: friend, user_receiver: user, status: :sended)
      end
    end

    it { friends.should match_array(user.pending_invitations) }
  end

  describe '#full_name' do
    let(:user) { create(:user, name: 'Name', surname: 'Surname') }

    it { expect(user.full_name).to eq('Name Surname') }
  end
end
