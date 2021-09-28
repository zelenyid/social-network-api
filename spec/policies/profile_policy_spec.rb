require 'rails_helper'

RSpec.describe ProfilePolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  permissions :show? do
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

  permissions :ban? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'deny access if user is not admin' do
        expect(subject).not_to permit(user)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :unban? do
    context 'when auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'deny access if user is not admin' do
        expect(subject).not_to permit(user)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
