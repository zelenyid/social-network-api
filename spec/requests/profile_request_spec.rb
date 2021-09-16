require 'rails_helper'

RSpec.describe 'Profile', type: :request do
  let(:user) { create(:confirmed_user) }
  let(:admin) { create(:confirmed_user, admin: true) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:admin_headers) { get_headers(admin.email, admin.password) }

  describe 'GET /api/v2/profiles/:id' do
    before do
      get "/api/v2/profiles/#{user.id}", headers: headers
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json.id).to eq(user.id) }
    it { expect(json.email).to eq(user.email) }
  end

  describe 'PUT /api/v1/profiles/:id/ban' do
    before do
      put "/api/v1/profiles/#{user.id}/ban", headers: admin_headers
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json.id).to eq(user.id) }
    it { expect(json.email).to eq(user.email) }
    it { expect(json.banned).to eq(true) }
  end

  describe 'PUT /api/v1/profiles/:id/unban' do
    before do
      put "/api/v1/profiles/#{user.id}/unban", headers: admin_headers
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json.id).to eq(user.id) }
    it { expect(json.email).to eq(user.email) }
    it { expect(json.banned).to eq(false) }
  end
end
