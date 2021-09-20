class SocialNetwork::V2::Conversations < Grape::API
  helpers ::APIHelpers::AuthenticationHelper

  resource :conversations do
    before { authenticate! }

    # GET /api/v2/conversations
    desc 'Get all conversations of the current user'
    get do
      conversations = current_user.conversations

      present conversations, with: Entities::ConversationEntity
    end

    # POST /api/v2/conversations
    desc 'Create conversation'
    params do
      requires :conversation, type: Hash, desc: 'Conversation data' do
        requires :recipient_id, type: Integer, desc: 'Recipient ID'
      end
    end
    post do
      conversation = Conversation.between(current_user.id, params[:conversation][:recipient_id])

      conversation = if conversation.present?
                       conversation.first
                     else
                       Conversation.create!(params[:conversation].merge({ sender_id: current_user.id }))
                     end

      present conversation, with: Entities::ConversationEntity
    end
  end
end
