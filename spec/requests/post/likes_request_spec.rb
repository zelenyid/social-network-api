require 'rails_helper'

RSpec.describe 'Like CRUD', type: :request do
  let!(:user) { create(:confirmed_user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:user_post) { create(:post) }

  describe 'POST /api/v2/posts/:post_id/comments' do
    context 'when we send correct params' do
      before do
        post "/api/v2/posts/#{user_post.id}/likes", headers: headers
      end

      it 'show like' do
        expect(response).to have_http_status(:created)
        expect(json.status).to eq('Like created')
      end

      it 'deny creating 2 like from one person to one post' do
        post "/api/v2/posts/#{user_post.id}/likes", headers: headers

        expect(response).to have_http_status(:created)
        expect(json.status).to eq('You can\'t like more than once')
      end
    end

    context 'when we send incorrect post id' do
      before do
        post '/api/v2/posts/-1/likes', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'DELETE /api/v2/posts/:post_id/likes/:id' do
    let!(:like) { create(:like, post: user_post, user: user) }

    context 'when we send correct data' do
      it 'delete like' do
        expect do
          delete "/api/v2/posts/#{user_post.id}/likes/#{like.id}", headers: headers
        end.to change(Like, :count).by(-1)
      end
    end

    context 'when we send incorrect data' do
      before do
        delete '/api/v2/posts/-1/likes/-1', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send incorrect post id and correct like id' do
      before do
        delete "/api/v2/posts/-1/likes/#{like.id}", headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we send correct post id and incorrect like id' do
      before do
        delete "/api/v2/posts/#{user_post.id}/likes/-1", headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
