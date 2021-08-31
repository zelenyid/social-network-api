require 'rails_helper'

RSpec.describe 'Posts CRUD', type: :request do
  let!(:user) { create(:confirmed_user) }
  let(:headers) { get_headers(user.email, user.password) }

  describe 'GET /api/v2/posts' do
    context 'when we have posts' do
      before do
        create_list(:post, 6)
        get '/api/v2/posts', headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(6) }
    end

    context 'when we haven\'t posts' do
      before do
        get '/api/v2/posts', headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(0) }
    end
  end

  describe 'GET /api/v2/posts/:id' do
    let(:post) { create(:post) }

    it 'show post with correct id' do
      get "/api/v2/posts/#{post.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json.id).to eq(post.id)
      expect(json.content).to eq(post.content)
    end

    it 'show post with incorrect id' do
      get '/api/v2/posts/-1', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
