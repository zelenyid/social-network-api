require 'rails_helper'

RSpec.describe FriendshipPolicy, type: :policy do
  subject { described_class }

  let(:sender) { create(:user) }
  let(:receiver) { create(:user) }
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:friendship) { create(:friendship, user_sender: sender, user_receiver: receiver) }

  permissions :create? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user present' do
        expect(subject).to permit(user)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :update? do
    context 'when auth user' do
      it 'grants access if user is the receiver' do
        expect(subject).to permit(receiver, friendship)
      end

      it 'deny if not user\'s is not the receiver (sender)' do
        expect(subject).not_to permit(sender, friendship)
      end

      it 'deny if not user\'s is not the receiver (user)' do
        expect(subject).not_to permit(user, friendship)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :destroy? do
    context 'when auth user' do
      let(:another_user) { create(:user) }

      it 'grants access if user is the sender' do
        expect(subject).to permit(sender, friendship)
      end

      it 'grants access if user is the receiver' do
        expect(subject).to permit(receiver, friendship)
      end

      it 'deny if not user not sender and receiver' do
        expect(subject).not_to permit(user, friendship)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
