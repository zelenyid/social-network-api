require 'rails_helper'

RSpec.describe 'Profile', type: :request do
  let!(:user_a) { create(:confirmed_user, name: 'John', surname: 'Bez') }
  let(:headers) { get_headers(user_a.email, user_a.password) }

  describe 'GET /api/v2/search/by_full_name' do
    context 'when sent name' do
      before do
        create(:confirmed_user, name: 'John', surname: 'Mask', admin: true)
        get '/api/v2/search/by_full_name', params: { q: 'John' }, headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(2) }
    end

    context 'when sent name and surname' do
      before do
        create(:confirmed_user, name: 'John', surname: 'Mask', admin: true)
        get '/api/v2/search/by_full_name', params: { q: 'John Mask' }, headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(1) }
    end
  end
end
