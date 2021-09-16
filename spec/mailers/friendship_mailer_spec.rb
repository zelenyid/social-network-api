require 'rails_helper'

RSpec.describe FriendshipMailer, type: :mailer do
  describe 'notify' do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:mail) { described_class.with(sender: sender, receiver: receiver).friend_request }

    it 'renders the headers' do
      expect(mail.subject).to eq('You have one new friend request')
      expect(mail.to).to eq([receiver.email])
      expect(mail.from).to eq(['noreply@social_network.com'])
    end
  end
end
