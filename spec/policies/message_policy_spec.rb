require 'rails_helper'

RSpec.describe MessagePolicy, type: :policy do
  subject { described_class }

  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, sender: sender, recipient: recipient) }

  permissions :show? do
    context 'when auth user' do
      it 'grants access if user sender' do
        expect(subject).to permit(sender, conversation)
      end

      it 'grants access if user recipient' do
        expect(subject).to permit(recipient, conversation)
      end

      it 'deny access if user is not sender or recipient' do
        expect(subject).not_to permit(user, conversation)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :create? do
    context 'when auth user' do
      it 'grants access if user sender' do
        expect(subject).to permit(sender, conversation)
      end

      it 'grants access if user recipient' do
        expect(subject).to permit(recipient, conversation)
      end

      it 'deny access if user is not sender or recipient' do
        expect(subject).not_to permit(user, conversation)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
