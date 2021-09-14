require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:post) { create(:post, user: user) }

  permissions :index? do
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
      it 'grants access if user\'s post' do
        expect(subject).to permit(user, post)
      end

      it 'deny if not user\'s post' do
        expect(subject).not_to permit(admin, post)
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

      it 'grants access if user admin' do
        expect(subject).to permit(admin, post)
      end

      it 'grants access if user\'s post' do
        expect(subject).to permit(user, post)
      end

      it 'deny if not user\'s post' do
        expect(subject).not_to permit(another_user, post)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
