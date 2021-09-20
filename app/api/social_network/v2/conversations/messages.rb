class SocialNetwork::V2::Conversations::Messages < Grape::API
  helpers ::APIHelpers::AuthenticationHelper
  helpers ::APIHelpers::ExceptionHelper

  helpers do
    def conversation
      @conversation = current_user.conversations.find_by(id: params[:conversation_id])
      not_found if @conversation.blank?
    end
  end

  namespace 'conversations/:conversation_id' do
    resource :messages do
      before do
        authenticate!
        conversation
      end

      # GET /api/v2/conversations/:conversation_id/messages
      desc 'Get all messages of the conversation'
      params do
        requires :conversation_id, type: Integer, desc: 'Conversation ID'
      end
      get do
        messages = @conversation.messages

        present messages, with: Entities::MessageEntity
      end

      # POST /api/v2/conversations/:conversation_id/messages
      desc 'Create message in the conversation'
      params do
        requires :conversation_id, type: Integer, desc: 'Conversation ID'
        requires :message, type: Hash, desc: 'Conversation data' do
          requires :body, type: String, desc: 'Body'
        end
      end
      post do
        message = @conversation.messages.create(params[:message].merge({ user_id: current_user.id }))

        present message, with: Entities::MessageEntity
      end
    end
  end
end
