require 'rails_helper'

RSpec.describe 'Conversations CRUD', type: :request do
  let!(:user_sender) { create(:confirmed_user) }
  let!(:user_recipients) { create_list(:confirmed_user, 3) }
  let(:headers) { get_headers(user_sender.email, user_sender.password) }

  describe 'GET /api/v2/conversations' do
    context 'when we have conversations' do
      before do
        user_recipients.each do |recipient|
          create(:conversation, sender: user_sender, recipient: recipient)
        end

        get '/api/v2/conversations', headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(3) }
      it { expect(json.pluck(:id)).to match_array(user_sender.conversations.pluck(:id)) }
    end
  end

  describe 'POST /api/v2/conversations' do
    let(:valid_params) { { conversation: { recipient_id: user_recipients.first.id } } }

    context 'when we send correct data' do
      before do
        post '/api/v2/conversations', params: valid_params.to_json, headers: headers
      end

      it 'show conversation' do
        expect(response).to have_http_status(:created)
        expect(json.recipient_id).to eq(valid_params[:conversation][:recipient_id])
        expect(json.sender_id).to eq(user_sender.id)
      end
    end

    context 'when conversations present' do
      before do
        create(:conversation, sender: user_sender, recipient: user_recipients.first)
        post '/api/v2/conversations', params: valid_params.to_json, headers: headers
      end

      it 'show conversation' do
        expect(response).to have_http_status(:created)
        expect(json.recipient_id).to eq(valid_params[:conversation][:recipient_id])
        expect(json.sender_id).to eq(user_sender.id)
      end
    end
  end
end
