require 'rails_helper'

RSpec.describe 'Friendship CRUD', type: :request do
  let!(:user) { create(:confirmed_user) }
  let!(:friend) { create(:confirmed_user) }
  let(:headers) { get_headers(user.email, user.password) }
  let(:friend_headers) { get_headers(friend.email, friend.password) }

  describe 'POST /api/v2/friendships/:friend_id' do
    context 'when we do not have friendship' do
      before do
        post "/api/v2/friendships/#{friend.id}", headers: headers
      end

      it { expect(response).to have_http_status(:created) }
      it { expect(json.user_sender_id).to eq(user.id) }
      it { expect(json.user_receiver_id).to eq(friend.id) }
      it { expect(json.status).to eq('sended') }
    end

    context 'when we have friendship' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend)
        post "/api/v2/friendships/#{friend.id}", headers: headers
      end

      it { expect(json.status).to eq('Friendship already exist') }
    end

    context 'when friend doesn\'t exist' do
      before do
        post '/api/v2/friendships/-1', headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /api/v2/friendships/:friend_id' do
    context 'when we have friendship invitation' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend, status: :sended)
        put "/api/v2/friendships/#{user.id}", headers: friend_headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.user_sender_id).to eq(user.id) }
      it { expect(json.user_receiver_id).to eq(friend.id) }
      it { expect(json.status).to eq('accepted') }
    end

    context 'when we don\'t have friendship invitation' do
      before do
        put "/api/v2/friendships/#{user.id}", headers: friend_headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when we have friendship' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend)
        put "/api/v2/friendships/#{user.id}", headers: friend_headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'DELETE /api/v2/friendships/:friend_id' do
    context 'when sender destroy sended invitation' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend, status: :sended)
        delete "/api/v2/friendships/#{friend.id}", headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.status).to eq('Friendship destroyed') }
    end

    context 'when sender destroy friendship' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend)
        delete "/api/v2/friendships/#{friend.id}", headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.status).to eq('Friendship destroyed') }
    end

    context 'when receiver destroy received invitation' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend, status: :sended)
        delete "/api/v2/friendships/#{user.id}", headers: friend_headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.status).to eq('Friendship destroyed') }
    end

    context 'when receiver destroy friendship' do
      before do
        create(:friendship, user_sender: user, user_receiver: friend)
        delete "/api/v2/friendships/#{user.id}", headers: friend_headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.status).to eq('Friendship destroyed') }
    end

    context 'when receiver destroy friendship that not exist' do
      before do
        delete "/api/v2/friendships/#{friend.id}", headers: headers
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
