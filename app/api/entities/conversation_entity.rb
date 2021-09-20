module Entities
  class ConversationEntity < Grape::Entity
    expose :id, documentation: {
      type: 'Integer',
      desc: 'The unique identifier'
    }

    expose :sender_id, documentation: {
      type: 'Integer',
      desc: 'ID of the sender'
    }

    expose :recipient_id, documentation: {
      type: 'Integer',
      desc: 'ID of the recipient'
    }

    expose :created_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the conversation was created'
    }

    expose :updated_at, documentation: {
      type: 'String',
      format: 'date-time',
      desc: 'When the conversation was updated'
    }
  end
end
