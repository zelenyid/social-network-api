require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:third_user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, post: post, user: second_user) }

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
      it 'grants access if user\'s comment' do
        expect(subject).to permit(second_user, comment)
      end

      it 'deny if not user\'s comment' do
        expect(subject).not_to permit(admin, comment)
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
        expect(subject).to permit(admin, comment)
      end

      it 'grants access if user\'s post' do
        expect(subject).to permit(user, comment)
      end

      it 'grants access if user\'s comment' do
        expect(subject).to permit(second_user, comment)
      end

      it 'deny if not user\'s comment' do
        expect(subject).not_to permit(third_user, comment)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
