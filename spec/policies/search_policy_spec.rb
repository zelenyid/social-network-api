require 'rails_helper'

RSpec.describe SearchPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  permissions :by_full_name? do
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
end
