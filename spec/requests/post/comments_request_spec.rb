require 'rails_helper'

RSpec.describe 'Comment CRUD', type: :request do
  let!(:user) { create(:confirmed_user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:user_post) { create(:post) }

  describe 'GET /api/v2/posts/:post_id/comments' do
    context 'when we have comments' do
      before do
        create_list(:comment, 4, post: user_post)
        get "/api/v2/posts/#{user_post.id}/comments", headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(4) }
    end

    context 'when we haven\'t comments' do
      before do
        get "/api/v2/posts/#{user_post.id}/comments", headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(0) }
    end

    context 'when we send incorrect post id' do
      before do
        get '/api/v2/posts/-1/comments', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /api/v2/posts/:post_id/comments' do
    let(:valid_params) { { comment: { content: 'Comment 1' } } }
    let(:invalid_params) { { invalid: { invalid: :invalid } } }

    context 'when we send correct data' do
      before do
        post "/api/v2/posts/#{user_post.id}/comments", params: valid_params.to_json, headers: headers
      end

      it 'show post' do
        expect(response).to have_http_status(:created)
        expect(json.content).to eq(valid_params[:comment][:content])
        expect(json.user_id).to eq(user.id)
      end
    end

    context 'when we send incorrect post id' do
      before do
        post '/api/v2/posts/-1/comments', params: valid_params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /api/v2/posts/:post_id/comments/:id' do
    let(:comment) { create(:comment, post: user_post, user: user) }
    let(:params) { { comment: { content: 'Comment 1 edited' } } }
    let(:invalid_params) { { invalid: { invalid: :invalid } } }

    context 'when we send correct data and id' do
      before do
        put "/api/v2/posts/#{user_post.id}/comments/#{comment.id}", params: params.to_json, headers: headers
      end

      it 'show comment' do
        expect(response).to have_http_status(:ok)
        expect(json.content).to eq(params[:comment][:content])
        expect(json.user_id).to eq(user.id)
      end
    end

    context 'when we send incorrect comment id and correct data and post id' do
      before do
        put "/api/v2/posts/#{user_post.id}/comments/-1", params: params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect post id and correct data and comment id' do
      before do
        put "/api/v2/posts/-1/comments/#{comment.id}", params: params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect post id and comment id and correct data' do
      before do
        put '/api/v2/posts/-1/comments/-1', params: params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect id and incorrect data' do
      before do
        put '/api/v2/posts/-1/comments/-1', params: invalid_params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:bad_request) }
    end

    context 'when we send correct id and incorrect data' do
      before do
        put "/api/v2/posts/#{user_post.id}/comments/#{comment.id}", params: invalid_params.to_json, headers: headers
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end

  describe 'DELETE /api/v2/posts/:post_id/comments/:id' do
    let!(:comment) { create(:comment, post: user_post, user: user) }

    context 'when we send correct data' do
      it 'delete post' do
        expect do
          delete "/api/v2/posts/#{user_post.id}/comments/#{comment.id}", headers: headers
        end.to change(Comment, :count).by(-1)
      end
    end

    context 'when we send incorrect data' do
      before do
        delete '/api/v2/posts/-1/comments/-1', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect post id and correct comment id' do
      before do
        delete "/api/v2/posts/-1/comments/#{comment.id}", headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send correct post id and incorrect comment id' do
      before do
        delete "/api/v2/posts/#{user_post.id}/comments/-1", headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
