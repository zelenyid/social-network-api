require 'rails_helper'

RSpec.describe MonthlyStatisticMailer, type: :mailer do
  describe 'show' do
    let(:user) { create(:user) }
    let(:mail) { described_class.with(user: user).show }

    it 'renders the headers' do
      expect(mail.subject).to eq('Monthly Statistic')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@social_network.com'])
    end
  end
end
