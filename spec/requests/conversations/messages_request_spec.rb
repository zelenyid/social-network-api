require 'rails_helper'

RSpec.describe 'Messages CRUD', type: :request do
  let!(:user_sender) { create(:confirmed_user) }
  let!(:user_recipient) { create(:confirmed_user) }
  let!(:conversation) { create(:conversation, sender: user_sender, recipient: user_recipient) }

  let(:headers) { get_headers(user_sender.email, user_sender.password) }

  describe 'GET /api/v2/conversations/:conversation_id/messages' do
    context 'when we have messages' do
      before do
        create_list(:message, 4, body: 'hello', conversation: conversation, user_id: user_sender.id)

        get "/api/v2/conversations/#{conversation.id}/messages", headers: headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(json.count).to eq(4) }
      it { expect(json.pluck(:id)).to match_array(conversation.messages.pluck(:id)) }
    end
  end

  describe 'POST /api/v2/conversations/:conversation_id/messages' do
    let(:valid_params) { { message: { body: 'hello' } } }

    context 'when we send correct data' do
      before do
        post "/api/v2/conversations/#{conversation.id}/messages", params: valid_params.to_json, headers: headers
      end

      it 'show message' do
        expect(response).to have_http_status(:created)
        expect(json.body).to eq(valid_params[:message][:body])
        expect(json.user_id).to eq(user_sender.id)
      end
    end
  end
end
