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
    let(:user_post) { create(:post) }

    context 'when we send correct id' do
      before do
        get "/api/v2/posts/#{user_post.id}", headers: headers
      end

      it 'show post' do
        expect(response).to have_http_status(:ok)
        expect(json.id).to eq(user_post.id)
        expect(json.content).to eq(user_post.content)
      end
    end

    context 'when we send incorrect id' do
      before do
        get '/api/v2/posts/-1', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/v2/posts' do
    let(:valid_params) { { post: { content: 'Content 1' } } }
    let(:invalid_params) { { invalid: { invalid: :invalid } } }

    context 'when we send correct data' do
      before do
        post '/api/v2/posts', params: valid_params.to_json, headers: headers
      end

      it 'show post' do
        expect(response).to have_http_status(:created)
        expect(json.content).to eq(valid_params[:post][:content])
        expect(json.user_id).to eq(user.id)
      end
    end

    context 'when we send incorrect data' do
      before do
        post '/api/v2/posts', params: invalid_params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'PUT /api/v2/posts/:id' do
    let(:user_post) { create(:post, user: user) }
    let(:params) { { post: { content: 'Content 1' } } }
    let(:invalid_params) { { invalid: { invalid: :invalid } } }

    context 'when we send correct data and id' do
      before do
        put "/api/v2/posts/#{user_post.id}", params: params.to_json, headers: headers
      end

      it 'show post' do
        expect(response).to have_http_status(:ok)
        expect(json.content).to eq(params[:post][:content])
        expect(json.user_id).to eq(user.id)
      end
    end

    context 'when we send incorrect id and correct data' do
      before do
        put '/api/v2/posts/-1', params: params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect id and incorrect data' do
      before do
        put '/api/v2/posts/-1', params: invalid_params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'DELETE /api/v2/posts/:id' do
    let!(:user_post) { create(:post, user: user) }

    context 'when we send correct data' do
      it 'delete post' do
        expect do
          delete "/api/v2/posts/#{user_post.id}", headers: headers
        end.to change(Post, :count).by(-1)
      end
    end

    context 'when we send incorrect data' do
      before do
        delete '/api/v2/posts/-1', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
