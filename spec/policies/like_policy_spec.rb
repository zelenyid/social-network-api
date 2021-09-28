require 'rails_helper'

RSpec.describe LikePolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }

  permissions :create? do
    context 'when auth user' do
      it 'grants access if not user\'s post' do
        expect(subject).to permit(another_user, post)
      end

      it 'deny if user\'s post' do
        expect(subject).not_to permit(user, post)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end

  permissions :destroy? do
    context 'when auth user' do
      let(:like) { create(:like, user: another_user, post: post) }

      it 'grants access if user\'s like' do
        expect(subject).to permit(another_user, like)
      end

      it 'deny if not user\'s like' do
        expect(subject).not_to permit(user, like)
      end
    end

    context 'when a visitor' do
      let(:user) { nil }

      it { is_expected.not_to permit(user) }
    end
  end
end
